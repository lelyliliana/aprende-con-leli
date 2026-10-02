const DATA = {
  areas: "./src/data/areas.json",
  courses: "./src/data/courses.json",
  paths: "./src/data/paths.json"
};

async function loadJSON(url) {
  const response = await fetch(url);
  if (!response.ok) throw new Error(`No fue posible cargar ${url}`);
  return response.json();
}

function escapeHTML(value = "") {
  return String(value)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

function areaCard(area, count) {
  return `
    <article class="card area-card">
      <span class="count">${count} ${count === 1 ? "curso" : "cursos"}</span>
      <h3>${escapeHTML(area.name)}</h3>
      <p>${escapeHTML(area.description)}</p>
    </article>`;
}

function pathCard(path, coursesById) {
  const names = path.courses
    .map(id => coursesById.get(id)?.title)
    .filter(Boolean);

  return `
    <article class="card path-card">
      <span class="tag">Ruta</span>
      <h3>${escapeHTML(path.title)}</h3>
      <p>${escapeHTML(path.description)}</p>
      <p class="sequence">${names.map(escapeHTML).join(" → ")}</p>
    </article>`;
}

function courseCard(course) {
  const repoURL = `https://github.com/${course.sourceRepository}`;
  const technologies = (course.technologies || [])
    .map(item => `<span class="chip">${escapeHTML(item)}</span>`)
    .join("");

  return `
    <article class="card course-card">
      <div>
        <span class="tag">${escapeHTML(course.level)}</span>
        <h3>${escapeHTML(course.title)}</h3>
        <div class="chips">${technologies}</div>
      </div>
      <a class="text-link" href="${repoURL}" target="_blank" rel="noreferrer">Explorar material →</a>
    </article>`;
}

async function init() {
  try {
    const [areas, courses, paths] = await Promise.all([
      loadJSON(DATA.areas),
      loadJSON(DATA.courses),
      loadJSON(DATA.paths)
    ]);

    const availableAreas = areas.filter(item => item.status === "available");
    const availableCourses = courses.filter(item => item.status === "available");
    const availablePaths = paths.filter(item => item.status === "available");
    const coursesById = new Map(availableCourses.map(course => [course.id, course]));

    document.querySelector("#areas-grid").innerHTML = availableAreas
      .map(area => areaCard(area, availableCourses.filter(course => course.area === area.id).length))
      .join("");

    document.querySelector("#paths-grid").innerHTML = availablePaths
      .map(path => pathCard(path, coursesById))
      .join("");

    document.querySelector("#courses-grid").innerHTML = availableCourses
      .map(courseCard)
      .join("");
  } catch (error) {
    console.error(error);
    document.querySelector("main").insertAdjacentHTML(
      "beforeend",
      '<p class="error">No fue posible cargar el catálogo en este momento.</p>'
    );
  }
}

init();
