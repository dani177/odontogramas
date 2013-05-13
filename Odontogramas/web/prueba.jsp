<!doctype html>
<html lang="en">
    <head>

        <title>Mega Image Viewer</title>

        <!-- style sheets -->
        <link rel="stylesheet" type="text/css" href="css/reset.css" />
        <link rel="stylesheet" type="text/css" href="css/main.css" />
        <link rel="stylesheet" type="text/css" href="css/form.css" />
        <!-- ColorBox css -->
        <link rel="stylesheet" type="text/css" href="css/colorbox.css" />
        <!-- jQuery ThemeRoller -->
        <link rel="stylesheet" type="text/css" href="css/custom-theme/jquery-ui-1.8.21.custom.css" />
        <!-- lhpMegaImgViewer plugin css -->
        <link rel="stylesheet" type="text/css" href="css/lhp_miv.css" />

        <!-- js files -->
        <!-- jQuery framework -->
        <script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
        <!-- jQuery ui -->
        <script type="text/javascript" src="js/jquery-ui-1.8.21.custom.min.js"></script>
        <!-- jQuery colorbox plugin -->
        <script type="text/javascript" src="js/jquery.colorbox-min.js"></script>
        <!-- jQuery easing plugin-->
        <script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
        <!-- jQuery mousewheel plugin-->
        <script type="text/javascript" src="js/jquery.mousewheel.min.js"></script>
        <!-- lhpMegaImgViewer plugin -->
        <script type="text/javascript" src="js/jquery.lhpMegaImgViewer.min.js"></script>
        <!-- preview main js code -->
        <script type="text/javascript" >
            $(function(){
                var customizeMeStt = {
                    'viewportWidth' : '100%',
                    'viewportHeight' : '100%',
                    'startScale' : 0.1,
                    'startX' : 1000,
                    'startY' : 500,
                    'animTime' : 500,
                    'draggInertia' : 10,
                    'contentUrl' : 'img/1.jpg',
                    'intNavEnable' : true,
                    'intNavPos' : 'B',
                    'intNavAutoHide' : false
                };
                $("#customizeMe").lhpMegaImgViewer(customizeMeStt);
            })
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /></head>
    <body>
        <div id="wrapper">
            <div id="header">
                <p>The mega image viewer jQuery plugin allows you to easily replace &lt;div&gt; tags<br />with <strong>animated image viewers.</strong></p>
                <p>Viewer used for displaying high-resolution object (image - JPG, PNG, GIF).<br />
                    Viewer displays the given display object inside the user-defined viewport area.<br />
                    Viewer allows to <strong>control the position and zoom</strong> of the object displayed<br />inside the viewport. Viewer controls the sliding and zoom of the displayed object<br />so that the viewport area will be filled completely.<br /><br />
                    If the viewport size is greater than the size of the displayed object,<br />the object is scaled over 100% to fit the viewport (zoom is disabled).
                </p>
                <strong>Features:</strong>
                <ol>
                    <li><strong>Touch support for mobile devices.</strong></li>
                    <li>Mouse or Touch drag.</li>
                    <li>Mouse wheel to zoom/unzoom.</li>
                    <li>Mouse click or Touch move to center viewport.</li>
                    <li><strong>Possible viewport resize on runtime.</strong></li>
                    <li>Package contains a example for building <strong>thumbnail gallery.</strong></li>
                    <li>Package contains a example for building <strong>lightbox gallery</strong> (ColorBox Gallery).</li>
                    <li>Cross-browser compatible ? Image Viewer is compatible with IE, CHROME, FIREFOX, OPERA, SAFARI.</li>
                    <li><strong>Very easy installation</strong> on your html page.</li>
                    <li>Very smooth animations.</li>
                    <li>Fully scalable.</li>
                </ol>
                <strong>Viewer functionality:</strong>
                <ol>
                    <li>set start coordinates and scale</li>
                    <li>navigation bar (enabled / disabled)</li>
                    <li>navigation bar autohide</li>
                    <li>set the <strong>navigation bar position</strong> (acceptable values: TL, T, TR, L, R, BL, B, BR)</li>
                    <li>set animation duration</li>
                    <li>set drag inertia</li>
                    <li>set image source from javascript {"contentUrl" : "images/my_image.jpg"} (relative or absolute path)</li>
                    <li>set image source from html &lt;img src="images/my_image.jpg"/&gt;</li>
                    <li><strong>dispatch event 'mivChange'</strong> with information whether it is possible to move and zoom the display object</li>
                </ol>
                <br /><br />
                <ul id="menu">
                    <li><a href="#firstSample" title="First example">First example</a></li>
                    <li><a href="#secondSample" title="Second example">Second example</a></li>
                    <li><a href="#thridSample" title="Thrid example">Thrid example</a></li>
                    <li><a href="#fourthSample" title="Fourth example">Fourth example</a></li>
                </ul>

            </div>
            <br class="floatClr" />
            <hr />
            <div id="firstSample" class="sample">
                <a href="#header" class="topBtt" title="top">top</a>
                <h1><span>First Example /</span> Basic Usage</h1>
                <p>This is an example of using the plugin for a single viewer on your website. jQuery plugin lhpMegaImgViewer lets you create several viewer instances. All you need to do is to include the necessary JavaScript files in the &lt;head&gt; section (details in the docs), adjust the settings to fit your needs and activate the plugin (for chosen elements) by pasting the JavaScript code below.</p>
                <img style="display:block; margin:0 auto;" src="gfx/interactiv.jpg" alt="interactiv" />
                <br />
                <div id="customizeMe"></div>
                <div class="customizeMeForm"> 
                    <div class="tipContainer"></div>
                    <p style="margin:6px; text-align:center;">CUSTOMIZE:</p>
                    <form action="./" />
                    <div class="cell halfCell topCell">
                        <span class="tip" data-txt="Defines width of the area in which image will be displayed inside the outer div (myDiv).<br/>Size can be given in pixels, ems, percentages."></span>
                        <label for="cm_btt_viewportWidth">viewport width</label>
                        <div class="inner">
                            <input type="text" class="input_text" name="cm_btt_viewportWidth" id="cm_btt_viewportWidth" />
                        </div> 
                    </div>

                    <div class="cell halfCell topCell lastCell">
                        <span class="tip" data-txt="Defines duration in ms of the scale and position animations."></span>
                        <label for="cm_btt_animTime">animation time</label>
                        <div class="inner">
                            <input type="text" class="input_text number" name="cm_btt_animTime" id="cm_btt_animTime" /> 
                        </div> 
                    </div>

                    <div class="cell halfCell">
                        <span class="tip" data-txt="Defines height of the area in which image will be displayed inside the outer div (myDiv).<br/>Size can be given in pixels, ems, percentages."></span>
                        <label for="cm_btt_viewportHeight">viewport height</label>
                        <div class="inner">
                            <input type="text" class="input_text" name="cm_btt_viewportHeight" id="cm_btt_viewportHeight" />
                        </div> 
                    </div>

                    <div class="cell halfCell lastCell">
                        <span class="tip" data-txt="Defines inertia after dragging."></span>
                        <label for="cm_btt_draggInertia">dragging inertia</label>
                        <div class="inner">
                            <input type="text" class="input_text number" name="cm_btt_draggInertia" id="cm_btt_draggInertia" /> 
                        </div> 
                    </div>

                    <div class="cell halfCell">
                        <span class="tip" data-txt="Defines start scale."></span>
                        <label for="cm_btt_startScale">start scale</label>
                        <div class="inner">
                            <input type="text" class="input_text number" name="cm_btt_startScale" id="cm_btt_startScale" />
                        </div> 
                    </div>

                    <div class="cell halfCell lastCell">
                        <span class="tip" data-txt="Defines the navigation bar enabled/disabled."></span>
                        <label for="cm_btt_intNavEnable">navigation enable</label>
                        <div class="inner">
                            <select class="select_option boolean" name="cm_btt_intNavEnable" id="cm_btt_intNavEnable">
                                <option />true
                                <option />false
                            </select> 
                        </div> 
                    </div>

                    <div class="cell halfCell">
                        <span class="tip" data-txt="Defines start coordinate x in px, in the display object frame of reference,<br/>which will be moved to the center of the viewport, if it is possible."></span>
                        <label for="cm_btt_startX">start X</label>
                        <div class="inner">
                            <input type="text" class="input_text number" name="cm_btt_startX" id="cm_btt_startX" />
                        </div> 
                    </div>

                    <div class="cell halfCell lastCell">
                        <span class="tip" data-txt="Defines the navigation bar position."></span>
                        <label for="cm_btt_intNavPos">navigation position</label>
                        <div class="inner">
                            <select class="select_option" name="cm_btt_intNavPos" id="cm_btt_intNavPos">
                                <option />T
                                <option />L
                                <option />R
                                <option />B
                                <option />TL
                                <option />TR
                                <option />BL
                                <option />BR
                            </select>
                        </div> 
                    </div>

                    <div class="cell halfCell">
                        <span class="tip" data-txt="Defines start coordinate y in px, in the display object frame of reference,<br/>which will be moved to the center of the viewport, if it is possible."></span>
                        <label for="cm_btt_startY">start Y</label>
                        <div class="inner">
                            <input type="text" class="input_text number" name="cm_btt_startY" id="cm_btt_startY" />
                        </div> 
                    </div>

                    <div class="cell halfCell lastCell">
                        <span class="tip" data-txt="Defines the navigation bar autohide."></span>
                        <label for="cm_btt_intNavAutoHide">navigation autohide</label>
                        <div class="inner">
                            <select class="select_option boolean" name="cm_btt_intNavAutoHide" id="cm_btt_intNavAutoHide">
                                <option />true
                                <option />false
                            </select> 
                        </div> 
                    </div>

                    <div class="cell lastCell">
                        <span class="tip" data-txt="Defines a path for an image source. This param is optional.<br/>Instead you can use the HTML image tag (see DOC - STEP 2B - ACTIVATE THE PLUGIN (IMAGE SOURCE FROM HTML))."></span>
                        <label for="cm_btt_contentUrl">content url</label>
                        <div class="inner">
                            <input type="text" class="input_text" name="cm_btt_contentUrl" id="cm_btt_contentUrl" /> 
                        </div> 
                    </div>


                    </form>
                </div>
                <img id="resizeIco" src="gfx/resize.jpg" alt="resize" />
                <br class="floatClr" />
                <br />javascript code:<br />
                <pre class="jsCode"></pre>
                html code:<br />
                <pre class="htmlCode">&lt;div id="<span>myDiv</span>" style="width:500px; height:300px; overflow:hidden; border:solid 1px #a6a6a6;"&gt;&lt;/div&gt;</pre>
                <hr />
            </div>
            <div id="secondSample" class="sample">
                <a href="#header" class="topBtt" title="top">top</a>
                <h1><span>Second Example /</span> Plugin Methods</h1>
                <p>This is an example of using the plugin methods. Use this code if you want to create your own navigation menu.</p>
                <div id="secCntr">
                    <img src="img/2.jpg" />
                </div>
                <div style="width:489px; float:left; margin-left:17px;">
                    javascript code:<br />
                    <pre class="jsCode">var <span>pluginMethodsStt</span> = {
	'viewportWidth' : '100%',
	'viewportHeight' : '100%'
};	
$('<span>#secCntr</span>').lhpMegaImgViewer(<span>pluginMethodsStt</span>);</pre>
                    html code:<br />
                    <pre class="htmlCode">&lt;div id="<span>secCntr</span>" style="width:450px; height:500px; overflow:hidden;"&gt;
	&lt;img src="img/2.jpg"/&gt;
&lt;/div&gt;</pre>
                    <ul id="publicMethods">
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( pluginMethodsStt );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'setPosition', 1300, 300, 0.8 );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'moveUp' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'moveDown' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'moveLeft' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'moveRight' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'moveStop' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'zoom' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'unzoom' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'zoomStop' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'fitToViewport' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'fullSize' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'adaptsToContainer' );</a></li>
                        <li><a href="#">$('#secCntr').lhpMegaImgViewer( 'destroy' );</a></li>
                    </ul>
                </div>
                <br class="floatClr" />


                <hr />
            </div>
            <div id="thridSample" class="sample">
                <a href="#header" class="topBtt" title="top">top</a>
                <h1><span>Thrid Example /</span> Thumbnail Gallery</h1>
                <p>This is an example of using the lhpMegaImgViewer plugin for building a thumbnail gallery on your website.</p>
                <div id="trdCntr"></div>
                <div id="galleryThumbImg">
                    <a href="img/1.jpg"><img src="img/thumb-1.jpg" /></a> 
                    <a href="img/2.jpg"><img src="img/thumb-2.jpg" /></a> 
                    <a href="img/3.jpg"><img src="img/thumb-3.jpg" /></a> 
                    <a href="img/4.jpg"><img src="img/thumb-4.jpg" /></a> 
                    <a href="img/5.jpg"><img src="img/thumb-5.jpg" /></a>
                </div>
                <hr />
            </div>
            <div id="fourthSample" class="sample">
                <a href="#header" class="topBtt" title="top">top</a>
                <h1><span>Fourth Example /</span> ColorBox Gallery</h1>
                <p>The last example shows the usage of the lhpMegaImgViewer plugin in ligthbox gallery. This example using <a href="http://www.jacklmoore.com/colorbox" target="_blank" title="colorbox">ColorBox</a>, w lightweight customizable lightbox plugin for jQuery.</p>
                <a href="img/1.jpg" class="group1"><img src="img/thumb-1.jpg" /></a> 
                <a href="img/2.jpg" class="group1"><img src="img/thumb-2.jpg" /></a> 
                <a href="img/3.jpg" class="group1"><img src="img/thumb-3.jpg" /></a> 
                <a href="img/4.jpg" class="group1"><img src="img/thumb-4.jpg" /></a> 
                <a href="img/5.jpg" class="group1"><img src="img/thumb-5.jpg" /></a> 
                <hr />
            </div>
        </div>
    </body>
</html>