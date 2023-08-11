function toggleExpandableAnnotation(event) {
    let $element = $(event.currentTarget);
    let $sibling = $element.next('.expandable-annotation-view');
    if ($sibling.hasClass('collapsed-annotation-view')) {
        $sibling.removeClass("collapsed-annotation-view").addClass("expanded-annotation-view");
        $element.removeClass("annotation-sibling-is-collapsed").addClass("annotation-sibling-is-expanded");
    } else {
        $sibling.removeClass("expanded-annotation-view").addClass("collapsed-annotation-view");
        $element.removeClass("annotation-sibling-is-expanded").addClass("annotation-sibling-is-collapsed");
    }
}
function addExpandableAnnotations() {
    $(".expandable-annotation-label")
        .click(toggleExpandableAnnotation);
}

$(document).ready(addExpandableAnnotations);
