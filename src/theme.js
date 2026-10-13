(() => {
  const root = document.documentElement;
  const storageKey = "aprende-con-leli-theme";
  const systemTheme = window.matchMedia("(prefers-color-scheme: dark)");
  let preference = null;
  try {
    const saved = localStorage.getItem(storageKey);
    if (saved === "light" || saved === "dark") preference = saved;
  } catch { /* El selector funciona aunque el navegador bloquee el almacenamiento. */ }

  function applyTheme(theme) {
    root.dataset.theme = theme;
    const button = document.querySelector(".theme-toggle");
    if (!button) return;
    const dark = theme === "dark";
    const label = dark ? "Activar modo claro" : "Activar modo oscuro";
    button.setAttribute("aria-label", label);
    button.setAttribute("aria-pressed", String(dark));
    button.title = label;
    button.hidden = false;
  }

  applyTheme(preference || (systemTheme.matches ? "dark" : "light"));
  document.addEventListener("DOMContentLoaded", () => {
    applyTheme(root.dataset.theme);
    document.querySelector(".theme-toggle")?.addEventListener("click", () => {
      preference = root.dataset.theme === "dark" ? "light" : "dark";
      applyTheme(preference);
      try { localStorage.setItem(storageKey, preference); } catch { /* Preferencia temporal. */ }
    });
  });
  systemTheme.addEventListener("change", event => {
    if (!preference) applyTheme(event.matches ? "dark" : "light");
  });
})();
