const DATA = {
  areas: "./src/data/areas.json",
  courses: "./src/data/courses.json"
};

async function loadJSON(url) {
  const response = await fetch(url, { cache: "no-store" });
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
      <a class="text-link" href="#cursos" data-area="${escapeHTML(area.id)}">Ver cursos →</a>
    </article>`;
}

const COURSE_VISUALS = {
  "algoritmos": ["01", "Lógica"],
  "java": ["{ }", "Java"],
  "spring-boot": ["API", "Spring"],
  "html-css": ["</>", "HTML · CSS"],
  "javascript": ["JS", "JavaScript"],
  "react": ["⚛", "React"],
  "bases-datos-sql": ["SQL", "PostgreSQL"],
  "arduino": ["∞", "Arduino"],
  "esp32": ["IoT", "ESP32"],
  "c": ["C", "C17"],
  "python": ["Py", "Python"],
  "fullstack": ["FS", "Full Stack"]
};

function courseVisual(course) {
  const [symbol, label] = COURSE_VISUALS[course.id] || ["<>", course.area || "Curso"];
  return `<div class="course-cover" aria-hidden="true">
    <span class="course-cover-symbol">${escapeHTML(symbol)}</span>
    <span class="course-cover-label">${escapeHTML(label)}</span>
  </div>`;
}

function courseCard(course, coursesById) {
  const repoURL = `https://github.com/${course.sourceRepository}`;
  const courseURL = course.internalPath || repoURL;
  const linkLabel = course.internalPath ? "Ver curso →" : "Explorar material →";
  const technologies = (course.technologies || [])
    .map(item => `<span class="chip">${escapeHTML(item)}</span>`)
    .join("");
  const prerequisiteNames = (course.prerequisites || []).map(id => coursesById.get(id)?.title).filter(Boolean);
  const nextNames = (course.next || []).map(id => coursesById.get(id)?.title).filter(Boolean);
  const relations = [
    prerequisiteNames.length ? `<span><strong>Antes:</strong> ${prerequisiteNames.map(escapeHTML).join(", ")}</span>` : "",
    nextNames.length ? `<span><strong>Después:</strong> ${nextNames.map(escapeHTML).join(", ")}</span>` : ""
  ].filter(Boolean).join("");

  return `
    <article class="card course-card">
      ${courseVisual(course)}
      <div class="course-card-body">
        <span class="tag">${escapeHTML(course.level)}</span>
        <h3>${escapeHTML(course.title)}</h3>
        <div class="chips">${technologies}</div>
        ${relations ? `<div class="course-relations">${relations}</div>` : ""}
      </div>
      <a class="text-link" href="${courseURL}"${course.internalPath ? "" : ' target="_blank" rel="noopener noreferrer"'}>${linkLabel}</a>
    </article>`;
}

async function init() {
  try {
    const [areas, courses] = await Promise.all([
      loadJSON(DATA.areas),
      loadJSON(DATA.courses)
    ]);

    const availableAreas = areas.filter(item => item.status === "available");
    const availableCourses = courses.filter(item => item.status === "available");
    const coursesById = new Map(availableCourses.map(course => [course.id, course]));

    document.querySelector("#areas-grid").innerHTML = availableAreas
      .map(area => areaCard(area, availableCourses.filter(course => course.area === area.id).length))
      .join("");

    const coursesGrid = document.querySelector("#courses-grid");
    const search = document.querySelector("#course-search");
    const status = document.querySelector("#catalog-status");
    const requestedArea = new URLSearchParams(window.location.search).get("area");
    let activeArea = availableAreas.some(area => area.id === requestedArea) ? requestedArea : "";

    const renderCourses = () => {
      const term = search.value.trim().toLowerCase();
      const selected = availableCourses.filter(course => {
        const inArea = !activeArea || course.area === activeArea;
        const haystack = [course.title, course.level, ...(course.technologies || [])].join(" ").toLowerCase();
        return inArea && (!term || haystack.includes(term));
      });
      coursesGrid.innerHTML = selected.map(course => courseCard(course, coursesById)).join("");
      status.textContent = `${selected.length} ${selected.length === 1 ? "curso encontrado" : "cursos encontrados"}`;
    };

    renderCourses();
    search.addEventListener("input", renderCourses);
    document.querySelector("#show-all").addEventListener("click", () => {
      activeArea = "";
      search.value = "";
      renderCourses();
    });
    document.querySelectorAll("[data-area]").forEach(link => {
      link.addEventListener("click", () => {
        activeArea = link.dataset.area;
        search.value = "";
        renderCourses();
      });
    });
  } catch (error) {
    console.error(error);
    document.querySelector("main").insertAdjacentHTML(
      "beforeend",
      '<p class="error">No fue posible cargar el catálogo en este momento.</p>'
    );
  }
}

init();
