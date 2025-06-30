class ScopedPreview extends HTMLElement {
  connectedCallback() {
    const shadow = this.attachShadow({ mode: 'closed' });

    // Move component HTML into shadow DOM
    const content = document.createElement('div');
    content.classList.add('govuk-template--rebranded', 'govuk-frontend-supported');
    content.innerHTML = this.innerHTML;
    shadow.appendChild(content);

    // Remove original component HTML
    this.innerHTML = '';

    // Attach GOV.UK Frontend CSS (with custom styles used in examples)
    const stylesheet = document.createElement('link');
    stylesheet.href = '/stylesheets/preview.css'
    stylesheet.rel = 'stylesheet';
    shadow.appendChild(stylesheet);

    // Initialize GOV.UK Frontend JavaScript
    requestAnimationFrame(() => this.initGovUKFrontend(shadow));
  }

  async initGovUKFrontend(shadowRoot) {
    try {
      const { initAll } = await import('/javascripts/govuk-frontend.min.js');

      // Get the scope to initialise component within
      const scope = shadowRoot.querySelector('.govuk-template--rebranded');
      if (!scope) return;

      // The service navigation component looks in the document a menu ID
      // Temporarily redirect document.getElementById to look within shadow DOM
      const originalGetElementById = document.getElementById;
      document.getElementById = (id) => shadowRoot.querySelector(`#${id}`);

      try {
        initAll({ scope });
      } finally {
        document.getElementById = originalGetElementById;
      }
    } catch (error) {
      console.error('Failed to initialize GOV.UK Frontend:', error);
    }
  }
}

window.customElements.define('scoped-preview', ScopedPreview);
