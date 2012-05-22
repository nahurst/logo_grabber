Logo Grabber
============

Given a url, makes a valiant effort to grab logo images from that page and any referenced stylesheets.

This is our first attempt at grabbing images given a url.

There's a lot of refactoring to do and isn't quite usable yet, but will be soon hopefully!

## Logo collection strategy ##

*   [done] grab all images with the text logo in it (TODO: should also include icon, avatar, etc probably)
*   [done] grab all background images with the same (TODO: how to deal with sprites? ex: stackoverflow.com)
*   [done] singular option to try to guess the best option (TODO: make this smarter)
*   [done] grab first image on the page if nothing is found yet
*   [done] grab favicon if all else fails (/favicon.ico, link rel favicon)
*   guess twitter handle, grab image from there (guess based on there being a twitter link within the retreived page, guess based on what's before the url, accept twitter url in options)

## Additional options to implement ##

*   try for twitter/facebook option
*   auto guess vs full set of images to choose from
*   callback to help with choosing which image
*   integrating with paperclip and actual images not just urls?

## Contributors ##

*   [Nathan Hurst](http://github.com/nahurst)
*   [Ross Cohen](http://github.com/a-ross-cohen)
*   [Ian Grabill](http://github.com/igrabes)