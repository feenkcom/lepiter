function formatSourceCodeBlock() {
  collapsibleCodeElements = document.querySelectorAll(".sourceCode");
  for (codeElement of collapsibleCodeElements) {
    smalltalkCode = codeElement.querySelector("code").textContent;
    displayedName = codeElement.querySelector("a").textContent;
    uniqueId = `block${codeElement
        .querySelector(".codeBlock")
        .getAttribute("id")}`;
    codeElement.innerHTML = `
<a data-toggle="collapse" href="#${uniqueId}" aria-expanded="false" aria-controls="${uniqueId}">
${displayedName}
</a>
<div class="collapse" id="${uniqueId}">
    <div class="card card-body">
        <span id="${uniqueId}" class="codeBlock">
            <code class="smalltalk">
                <pre>
${smalltalkCode}
                </pre>
            </code>
        </span>
    </div>
</div>`;
  }
}

function formatCodeBlock() {
  let plainTextCodeElements = document.querySelectorAll(".plaintext");
  for (codeElement of plainTextCodeElements) {
    codeElement.className = "nohighlight hljs";
  }
}

/**
 * Scroll to an active (selected) navigation item.
 * When a user clicks on a navigation item, the active (selected) navigation item
 * may not be visible since the navigation list displays items starting from the beginning.
 * This function find the active navigation item element and scrolls to this element.
 */
function scrollToActiveNavigationItem() {
  /* Display the selected navigation item in the viewport. */
  let activeNavigationItems = $('.nav-item.active');
  if (activeNavigationItems.length > 0) {
    activeNavigationItems[0].scrollIntoView({behavior: "instant", block: "center", inline: "start"});
  }
}

/**
 * Execute a callback each time an element becomes (partially) visible.
 * @param element is element that is observed
 * @param callback is a function that is executed each time the element becomes visible
 */
function onElementVisible(element, callback) {
  new IntersectionObserver((entries, observer) => {
    entries.forEach(entry => {
      if(entry.intersectionRatio > 0) {
        callback(element);
      }
    });
  }).observe(element);
}

async function onDOMContentLoaded() {

  /* Register for navigation list visibility changes. */
  let navigationList = $('#le-nav-collapsable');
  if (navigationList.length > 0)
    onElementVisible(navigationList[0], (list) => {
      /* We set a timeout because there is a navigation list animation
      * when displayed as a button dropdown. */
      setTimeout(scrollToActiveNavigationItem, 300);
    } );

  scrollToActiveNavigationItem();
  formatCodeBlock();
  hljs.initHighlightingOnLoad();
  formatSourceCodeBlock();
}

document.addEventListener("DOMContentLoaded", onDOMContentLoaded);
