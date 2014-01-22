// Equal height columns
var dataMatchHeight = function(){
  var isMobile = matchMedia(Foundation.media_queries['small']).matches;
  $("[data-match-height]").each(function(){
    var vals = $(this).find('[data-height-watch]');
    vals.height('inherit');
    // vals.each(function(){ $(this).height(''); });
    if (isMobile) return;
    var heights = vals.map(function(){ return $(this).height() });
    var max = Math.max.apply(null, heights);
    vals.height(max);
  });
};
$(window).on("resize load", dataMatchHeight);
