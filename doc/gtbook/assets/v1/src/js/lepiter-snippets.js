function toggleExpandableAnnotation(event) {
    let $element = $(event.currentTarget);
    let $sibling = $element.next('.expandable_annotation_body');
    if ($sibling.hasClass('hidden_annotation_v3')) {
        $sibling.removeClass("hidden_annotation_v3").addClass("visible_annotation_v3");
        $element.removeClass("collapsed_annotation_body").addClass("expanded_annotation_body");
    } else {
        $sibling.removeClass("visible_annotation_v3").addClass("hidden_annotation_v3");
        $element.removeClass("expanded_annotation_body").addClass("collapsed_annotation_body");
    }
}
function addExpandableAnnotations() {
    $(".expandable_annotation_label")
        .click(toggleExpandableAnnotation);
}

$(document).ready(addExpandableAnnotations);
