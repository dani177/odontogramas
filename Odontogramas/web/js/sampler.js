$(function ready(){

 


    function phone_frames(frames){
        var every= 1, stack= [];
        for(var i= 1; i <= frames; i+= every){
            var name= [i, '.jpeg'].join('');
            
            while (name.length < 6) name= '0'+name
            stack.push(name)
        }
        return stack
    }


    /*
  This method is NOT needed to initiate the Reel. It is here for switching Reels on and off.
  It essentially is a shortcut for `$(target).reel(options)`
  You don't need to use it
  */
    prepare_reel_sample= function(target){
        var
        $sample= $(target).parent('.sample'),
        // opts= $('pre', $sample).text(),
        options= {
            footage:  18,
            cw:       false,
            orbital:  9,
            inversed: true,
            speed:    0.3,
            path:     'phone/',
            images:   phone_frames(36)
        }

        $sample.click(function(e){
            if (!$(this).is('.on')){
                click_it(e);
                return false;
            }
        });
        $('h3', $sample).click(click_it);

        

        function click_it(e){
            var
            onoff= !$sample.hasClass('on'),
            $others= $('.sample').not($sample)
            if (!e.altKey){
                $others.removeClass('on');
                $('.jquery-reel', $others).trigger('teardown');
            }

            $sample[onoff ? 'addClass' : 'removeClass']('on');
            onoff && $(target).reel(options) || $(target).trigger('teardown');
            $.cookie('reel.test.sample', onoff ? $(target).selector : null);
            // $.cookie(onoff ? '')
            return false;
        }
    }

});