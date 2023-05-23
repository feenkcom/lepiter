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

async function onDOMContentLoaded() {
  /* Display the selected navigation item in the viewport. */
  let activeNavigationItems = $('.nav-item.active');
  if (activeNavigationItems.length > 0)
    activeNavigationItems[0].scrollIntoView({ behavior: "instant", block: "center", inline: "start" });

  formatCodeBlock();
  hljs.initHighlightingOnLoad();
  formatSourceCodeBlock();
}

document.addEventListener("DOMContentLoaded", onDOMContentLoaded);
