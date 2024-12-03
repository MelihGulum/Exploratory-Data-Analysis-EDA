var a = 0;
$(window).on('load',function() {
    if ($('#counter').length) { // checking if CountTo section exists in the page, if not it will not run the script and avoid errors
        var oTop = $('#counter').offset().top - window.innerHeight;
        if (a == 0 && $(window).scrollTop() > oTop) {
        $('.counter-value').each(function() {
            var $this = $(this),
            countTo = $this.attr('data-count');
            $({
            countNum: $this.text()
            }).animate({
                countNum: countTo
            },
            {
                duration: 2000,
                easing: 'swing',
                step: function() {
                $this.text(Math.floor(this.countNum));
                },
                complete: function() {
                $this.text(this.countNum);
                //alert('finished');
                }
            });
        });
        a = 1;
        }
    }
});
