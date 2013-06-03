
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" 
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="entity.controller.*"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
        HttpSession session1 = request.getSession();
        String aux = (String) session1.getAttribute("logueado");
        if (aux == null || aux.equals("")) {
        } else {
            RequestDispatcher rd = null;
            if (session1.getAttribute("administrador") != null) {
                rd = request.getRequestDispatcher("/vista/administrador/index.jsp");

            } else {
                if (session1.getAttribute("docente") != null) {
                    rd = request.getRequestDispatcher("/vista/docente/index.jsp");

                } else {
                    if (session1.getAttribute("medico") != null) {
                        rd = request.getRequestDispatcher("/vista/index2.jsp");

                    }
                }
            }

            rd.forward(request, response);
        }

    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Sistema para la Gesti&oacute;n de Informaci&oacute;n en el &Aacute;rea de Endodoncia</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="description" content="">
                <meta name="author" content="">

                    <!-- Le HTML5 shim, for IE6-8 support of HTML elements -->
                    <!--[if lt IE 9]>
                      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
                    <![endif]-->

                    <!-- Le styles -->
                    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap-responsive.min.css"/>
                    <link rel="stylesheet" href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css"/>

                    <style type="text/css">
                        .resolucion{
                            position: absolute;
                            top:15px;
                            right: 20px;
                        }
                        body {
                            position: relative;
                            background-color: #fff;
                            background-image: url("<%=request.getContextPath()%>/images/background.png");
                            background-repeat: repeat-x;
                            padding-top: 60px;
                            padding-bottom: 40px;

                        }
                        .navbar-fixed-top .brand {
                            font-weight: bold;
                            color: #000;
                            text-shadow: 0 1px 0 rgba(255,255,255,.1), 0 0 30px rgba(255,255,255,.125);
                            -webkit-transition: all .2s linear;
                            -moz-transition: all .2s linear;
                            transition: all .2s linear;
                        }
                        .navbar-fixed-top .brand:hover {
                            text-decoration: none;
                        }

                        .logo {
                            margin-bottom: 0;
                            margin-left: 0;
                            margin-right: 0;
                            margin-top: 0;
                            padding-bottom: 0;
                            padding-left: 0;
                            padding-right: 0;
                            padding-top: 0;
                            text-align: center;
                        }
                        .modal{
                            max-height: 520px;
                        }
                        #notificaciones {
                            bottom: 5px;
                            position: fixed;
                            right: 10px;
                            width: 250px;
                            z-index: 9999;
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
                
                            $("a[href='#registro']").click(function(){
                                $("#myModalRegistro").modal();
                            });
         
                
                            $('.dropdown-menu').find('form').click(function (e) {
                                var target = $(e.target);
                                if($(target).attr("class")!="close"){
                                    e.stopPropagation();
                                }
                    
                            });	 
                            $("#btnRegistro").click(function(){
                                $("#registro").submit();
                            })
                            $("#registro").validate({
                                submitHandler: function(){
                                    $.ajax({
                                        type: 'POST', 
                                        url: "<%=request.getContextPath()%>/formController?action=registrarM",
                                        data: $("#registro").serialize(),
                                        success: function(msg){
                                            if(msg==0){
                                                $("#registro").each (function(){
                                                    this.reset();
                                                });
                                                $('#myModalRegistro').modal('hide');
                                                var html = '<div class="alert alert-success fade in">'
                                                    +'<a class="close" data-dismiss="alert" href="#">&times;</a>'
                                                    +'<strong>Bien hecho!</strong> El registro se ha realizado con exito.'
                                                    +'</div>';

                                                $("#notificaciones").html(html);
                                                setTimeout(function(){
                                                    $(".alert-success").alert("close");
                                                }, 5000);
                                                        
                                            }else{
                                                        
                                                $('#myModalRegistro').modal('hide');
                                                var html2 = '<div class="alert alert-error fade in">'
                                                    +'<a class="close" data-dismiss="alert" href="#">&times;</a>'
                                                    +'<strong>Error!</strong> El registro no se pudo realizar debido a un error en el sistema.'
                                                    +'</div>';

                                                $("#notificaciones").html(html2);
                                                setTimeout(function(){
                                                    $(".alert-error").alert("close");
                                                }, 5000);
                                                      
                                            }
                                        } //fin success
                                    }); //fin $.ajax    
                                }
                            });
                
                            $("#formulario_login").validate({
                                errorLabelContainer:".alert-error",
                                submitHandler: function() {
                                    setTimeout(function () {
                                        $.ajax({
                                            url: '/Odontogramas/loginController',
                                            data: 'un='+ $('#codigo').val() +'&pw=' + $('#pass').val() + '&perfil='+ $('#tipo :selected').val(),
                                            type: 'post',
                                            success: function(msg){
                                   
                                                if(msg == 0) 
                                                {   
                                                    document.location='/Odontogramas/';
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
                                <div class="container" style="padding-top: 10px; padding-bottom: 10px;">
                                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </a>
                                    <a class="brand" href="#"><img src="<%=request.getContextPath()%>/img/LogoUdeC2.png" style="position: absolute;top:0;left:30px;"></img> Sistema para la Gesti&oacute;n de Informaci&oacute;n en el &Aacute;rea de Endodoncia</a>
                                    <img class="resolucion span2" src="<%=request.getContextPath()%>/img/SIGIE.jpg"></img>
                                    <ul class="nav pull-right">
                                        <li><a href="#registro">Crear cuenta</a></li>
                                        <li id="fat-menu" class="dropdown">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Iniciar Sesi&oacute;n <b class="caret"></b></a>
                                            <ul class="dropdown-menu" style="padding-top: 0px; padding-bottom: 0px;">
                                                <form class="well" id="formulario_login" action="" style="margin-bottom: 0px;">
                                                    <div class='alert alert-error' style="display: none">
                                                        <a data-dismiss='alert' class='close'>×</a>  
                                                        <strong>Error!</strong>Usuario y/o Contrase&ntilde;a incorrecto(s)
                                                    </div>
                                                    <label style="margin-top: 15px;">Perfil de ingreso</label>
                                                    <select id="tipo" name="tipo" class="span3">
                                                        <option>Estudiante</option>
                                                        <option>Docente</option>
                                                        <option>Administrador</option>
                                                    </select>
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

                        <div>
                            <div class="row">
                                <img src="<%=request.getContextPath()%>/img/banner.jpg" style="width: 100%;height: 250px;" ></img>
                            </div>

                            <div class="hero-unit span10" style="margin-top: 5px;padding-top: 5px;background-color: transparent">SIGIE UdeC es una herramienta diseñada con el fin de agilizar los procesos de Odontolog&iacute;a en los ambitos de Historias Cl&iacute;nicas y Comparaciones de Ex&aacute;menes Radiogr&aacute;ficos a los pacientes de la la Facultad.</div>
                            <div class="row">
                                <img src="<%=request.getContextPath()%>/img/Torre.jpg" style="position: absolute;bottom: 30px;right: 30px;"></img>                                
                            </div>

                            

                                
                                <p class="left" style="padding-left: 60px;">&copy; Universidad de Cartagena 2012</p>


                            

                        </div> <!-- /container -->
                        <div class="modal hide fade" id="myModalRegistro">
                            <div class="modal-header">
                                <a data-dismiss="modal" class="close">×</a>
                                <h3>Registro de M&eacute;dicos</h3>
                            </div>
                            <div class="modal-body">
                                <form id="registro" class="form-horizontal">
                                    <fieldset>
                                        <div class="control-group">
                                            <label for="cedula" class="control-label">C&eacute;dula</label>
                                            <div class="controls">
                                                <input type="text" id="input01" class="input-xlarge {required:true}" name="cedula">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label for="nombre" class="control-label">Nombres y Apellidos</label>
                                            <div class="controls">
                                                <input type="text" id="nombre" class="input-xlarge {required:true}" name="nombre">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label for="direccion" class="control-label">Direcci&oacute;n</label>
                                            <div class="controls">
                                                <input type="text" id="direccion" class="input-xlarge {required:true}" name="direccion">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label for="telefono" class="control-label">Tel&eacute;fono</label>
                                            <div class="controls">
                                                <input type="text" id="telefono" class="input-xlarge {required:true}" name="telefono">
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label for="curso" class="control-label">Curso</label>
                                            <div class="controls">
                                                <select name="curso" class="{required:true}">
                                                    <option selected="selected"></option> 
                                                    <c:set var="cursos" value="<%=new CursoJpaController().findCursoEntities()%>"></c:set>
                                                    <c:forEach items="${cursos}" var="row" varStatus="iter">
                                                        <option value="${row.idcurso}">${row.nombre}</option>    
                                                    </c:forEach>

                                                </select>
                                            </div>
                                        </div>
                                        <div class="control-group">
                                            <label for="codigo" class="control-label">C&oacute;digo</label>
                                            <div class="controls">
                                                <input type="text" id="codigo" class="input-xlarge {required:true}" name="codigo"/>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-primary" type="button" id="btnRegistro">Crear cuenta</button>
                            </div>

                        </div>
                        <div id="notificaciones"></div>
                    </body>
                    </html>
