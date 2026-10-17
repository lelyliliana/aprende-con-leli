"""Comprueba la navegación, los ejemplos de las lecciones y el catálogo."""
from pathlib import Path
from html.parser import HTMLParser
import json
import re
from urllib.parse import urlparse, unquote

ROOT = Path(__file__).resolve().parents[1]
REPO = ROOT.parents[1]
units = sorted(ROOT.glob('unidad*'))
assert len(units) == 22, 'Se esperan 22 unidades'
for unit in units:
    for name in ['README.md', 'PRACTICA.md', 'SOLUCIONES.md']:
        assert (unit / name).is_file(), f'Falta {unit.name}/{name}'
    for path in (unit / 'ejemplos').glob('*.php'):
        assert path.read_text().strip() in (unit / 'README.md').read_text(), f'Lección y código difieren: {path}'
    assert (unit / 'soluciones/reto.php').read_text().strip() in (unit / 'SOLUCIONES.md').read_text(), f'Solución y código difieren: {unit}'
manifest = json.loads((ROOT / 'scripts/ejemplos.json').read_text())
assert len(manifest) == 66, 'Se esperan tres ejemplos por unidad'
assert len({item['file'] for item in manifest}) == 66, 'Hay ejemplos repetidos en el manifiesto'
for item in manifest:
    assert (ROOT / item['file']).is_file() and (ROOT / item['expected']).is_file(), f"Falta un ejemplo: {item}"
lab_guides = sorted((ROOT / 'laboratorios').glob('*/README.md'))
assert len(lab_guides) == 10, 'Se esperan diez guías de laboratorio'
assert all('Lectura por estados' in (unit / 'README.md').read_text() for unit in units), 'Falta la lectura de ejemplos'
links = 0
for path in ROOT.rglob('*.md'):
    for target in re.findall(r'\]\(([^)]+)\)', path.read_text()):
        if '://' in target or target.startswith('#'):
            continue
        assert (path.parent / unquote(target.split('#')[0])).exists(), f'Enlace roto: {path}: {target}'
        links += 1

class LinkParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        global links
        for key, target in attrs:
            if key not in ('href', 'src') or not target or target.startswith('#'):
                continue
            parsed = urlparse(target)
            prefix = 'https://github.com/lelyliliana/aprende-con-leli/blob/main/'
            if target.startswith(prefix):
                assert (REPO / unquote(target[len(prefix):])).exists(), f'Enlace fuente roto: {target}'
            elif not parsed.scheme:
                assert (ROOT / unquote(parsed.path)).exists(), f'Recurso local roto: {target}'
            links += 1
LinkParser().feed((ROOT / 'index.html').read_text())
courses = json.loads((REPO / 'src/data/courses.json').read_text())
php = [course for course in courses if course['id'] == 'php']
assert len(php) == 1 and php[0]['modules'] == len(units), 'Catálogo incoherente'
assert (REPO / php[0]['internalPath'] / 'index.html').is_file(), 'Falta la portada'
assert '20 cursos' in (REPO / 'README.md').read_text() and len(courses) == 20, 'Conteo de cursos incoherente'
print(f'22 unidades, 66 ejemplos, 10 laboratorios y catálogo coherentes; {links} enlaces locales y de código comprobados.')
