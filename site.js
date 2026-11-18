const menuTrigger = document.querySelector('#menu-trigger');
const menu = document.querySelector('#site-menu');

if (typeof menu.showModal === 'function') {
  menuTrigger.setAttribute('aria-haspopup', 'dialog');
  menuTrigger.setAttribute('aria-controls', menu.id);
  menuTrigger.setAttribute('aria-expanded', 'false');
  document.querySelector('#page-links').hidden = true;

  menuTrigger.addEventListener('click', event => {
    event.preventDefault();
    menu.showModal();
    menuTrigger.setAttribute('aria-expanded', 'true');
  });

  menu.addEventListener('close', () => menuTrigger.setAttribute('aria-expanded', 'false'));
  menu.addEventListener('click', event => {
    if (event.target === menu) menu.close();
  });

  for (const link of menu.querySelectorAll('nav a')) {
    link.addEventListener('click', () => {
      menu.close();
      const section = document.getElementById(link.hash.slice(1));
      section.setAttribute('tabindex', '-1');
      section.focus({ preventScroll: true });
    });
  }
}

const topicSwitcher = document.querySelector('.topic-switcher');
const topicButtons = [...topicSwitcher.querySelectorAll('button')];
const topics = topicButtons.map(button => ({
  button,
  panel: document.getElementById(button.getAttribute('aria-controls')),
}));

function showTopic(activePanel) {
  for (const { button, panel } of topics) {
    const selected = panel === activePanel;
    button.setAttribute('aria-pressed', String(selected));
    if (!selected) panel.querySelectorAll('video').forEach(video => video.pause());
    panel.hidden = !selected;
  }
}

function handleResearchHash() {
  const target = document.getElementById(location.hash.slice(1));
  const panel = target?.closest('.topic-panel');
  if (!panel) return;
  showTopic(panel);
  const study = target.closest('details');
  if (study) study.open = true;
  target.scrollIntoView({ block: 'start', behavior: 'instant' });
}

for (const { button, panel } of topics) button.addEventListener('click', () => showTopic(panel));

for (const study of document.querySelectorAll('.study')) {
  study.addEventListener('toggle', () => {
    if (!study.open) study.querySelectorAll('video').forEach(video => video.pause());
  });
}

showTopic(topics[0].panel);
topicSwitcher.hidden = false;
handleResearchHash();
window.addEventListener('hashchange', handleResearchHash);
