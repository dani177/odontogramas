<!DOCTYPE html>
<html lang="en">
    <%
        HttpSession session1 = request.getSession();
        String aux = (String) session1.getAttribute("logueado");
        if (aux == null || aux.equals("")) {
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("/vista/index2.jsp");
            rd.forward(request, response);

        }

    %>
    
    <head>
        <meta charset="utf-8">
        <title>Odontogramas</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
        <!--[if lt IE 9]>
          <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

        <!-- Le styles -->
        <link href="assets/css/bootstrap.css" rel="stylesheet"> 
        <link href="assets/css/docs.css" rel="stylesheet"> 
        <style type="text/css">
            body {
                padding-top: 60px;
                padding-bottom: 40px;
            }
        </style>
        <!-- Le javascript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="assets/js/jquery.js"></script>
        <script src="assets/js/jquery.validate.js"></script>
        <script src="assets/js/jquery.metadata.js"></script>
        <script src="assets/js/bootstrap-transition.js"></script>
        <script src="assets/js/bootstrap-alert.js"></script>
        <script src="assets/js/bootstrap-modal.js"></script>
        <script src="assets/js/bootstrap-dropdown.js"></script>
        <script src="assets/js/bootstrap-button.js"></script>
        
        <script type="text/javascript">
            $(function(){
                $('.dropdown-menu').find('form').click(function (e) {
                    var target = $(e.target);
                    if($(target).attr("class")!="close"){
                        e.stopPropagation();
                    }
                    
                });	 
                
                $("#formulario_login").validate({
                        errorLabelContainer:".alert-error",
                        submitHandler: function() {
                            console.log("submitiando");
                            setTimeout(function () {
                                $.ajax({
                                url: '/Odontograma/loginController',
                                data: 'un='+ $('#codigo').val() +'&pw=' + $('#pass').val(),
                                type: 'post',
                                success: function(msg){
                                   
                                    if(msg == 0) 
                                    {   
                                        document.location='/Odontograma/';
                                    }
                                    else 
                                    { 
                                    }
                                } //fin success
                            });//fin ajax
                            
                        }, 400);//fin timeOut
                            
                    }               
                });
                
            });
	
        </script>

    </head>

    <body>

        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </a>
                    <a class="brand" href="#">Odontogramas</a>

                    <ul class="nav">
                        <li class="active"><a href="#">Inicio</a></li>
                        <li><a href="#about">Acerca de</a></li>
                        <li><a href="#contact">Contactenos</a></li>
                    </ul>

                    <ul class="nav pull-right">
                        <li id="fat-menu" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Iniciar Sesion <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <form class="well" id="formulario_login" action="">
                                    <div class='alert alert-error' style="display: none">
                                                <a data-dismiss='alert' class='close'>×</a>  
                                                <strong>Error!</strong>Usuario y/o Contrase&ntilde;a incorrecto(s)
                                            </div>
                                    <label>Usuario</label>
                                    <input type="text" id="codigo" name="codigo" class="span3 {required:true}" />
                                    <label>Contrase&ntilde;a</label>
                                    <input type="password" id="pass" name="pass" class="span3 {required:true}" />
                                    <label><a href="#">Olvidó su contrase&ntilde;a?</a></label>
                                    <button type="submit" class="btn btn-primary">Entrar</button>
                                </form><!--/form-->
                            </ul>

                        </li>
                    </ul>

                </div>
            </div>
        </div>

        <div class="container">

            <footer>
                <p>&copy; Universidad de Cartagena 2012</p>
            </footer>

        </div> <!-- /container -->

        
    </body>
</html>
