
$(document).ready(function(){
    $('.class_annotation').addClass("hidden_annotation");
    $('.class_annotation').click(function() {
      var $this = $(this);    
      if ($this.hasClass("hidden_annotation")) {
        $(this).removeClass("hidden_annotation").addClass("visible_annotation");
      } else {
        $(this).removeClass("visible_annotation").addClass("hidden_annotation");
      }
    });

    $('.method_annotation').addClass("hidden_annotation");
    $('.method_annotation').click(function() {
      var $this = $(this);    
      if ($this.hasClass("hidden_annotation")) {
        $(this).removeClass("hidden_annotation").addClass("visible_annotation");
      } else {
        $(this).removeClass("visible_annotation").addClass("hidden_annotation");
      }
    });
});
