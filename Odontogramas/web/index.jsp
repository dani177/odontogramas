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
            RequestDispatcher rd = request.getRequestDispatcher("/vista/index2.jsp");
            rd.forward(request, response);

        }

    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                                .modal{
                                    max-height: 520px;
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
                                                success: function(){
                                                  
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
                                                    data: 'un='+ $('#codigo').val() +'&pw=' + $('#pass').val(),
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
                                                <li><a href="#registro">Crear cuenta</a></li>
                                                <li id="fat-menu" class="dropdown">
                                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Iniciar Sesion <b class="caret"></b></a>
                                                    <ul class="dropdown-menu">
                                                        <form class="well" id="formulario_login" action="">
                                                            <div class='alert alert-error' style="display: none">
                                                                <a data-dismiss='alert' class='close'>�</a>  
                                                                <strong>Error!</strong>Usuario y/o Contrase&ntilde;a incorrecto(s)
                                                            </div>
                                                            <label>Usuario</label>
                                                            <input type="text" id="codigo" name="codigo" class="span3 {required:true}" />
                                                            <label>Contrase&ntilde;a</label>
                                                            <input type="password" id="pass" name="pass" class="span3 {required:true}" />
                                                            <label><a href="#">Olvid� su contrase&ntilde;a?</a></label>
                                                            <button type="submit" class="btn btn-primary">Entrar</button>
                                                        </form><!--/form-->
                                                    </ul>

                                                </li>
                                            </ul>

                                        </div>
                                    </div>
                                </div>

                                <div class="container" style="margin-top:-20px;">
                                    <div class="logo">
                                        <img class="center" alt="logo" src="images/logo2.png">
                                    </div>
                                    <div class="hero-unit" style="margin-top: -5px;">
                                        <h1>Bienvenido!</h1>
                                        <p>Eum hinc argumentum te, no sit percipit adversarium, ne qui feugiat persecuti. Odio omnes scripserit ad est, ut vidit lorem maiestatis his, putent mandamus gloriatur ne pro. Oratio iriure rationibus ne his, ad est corrumpit splendide. Ad duo appareat moderatius, ei falli tollit denique eos.!</p>
                                        <p><a class="btn btn-large btn-primary" href="about">Leer m&aacute;s �</a></p>
                                    </div>
                                    <div class="row">
                                        <div class="span4">
                                            <h2>Sitios</h2>
                                            <ul class="thumbnails">
                                                <li class="span4"><a class="thumbnail" href="sites">
                                                        <img alt="" src="images/odon.png"></a></li></ul>
                                            <p>La Facultad de Odontolog�a de la Universidad de Cartagena forma un profesional con conocimientos, habilidades y destrezas integrales en las �reas propias del saber. </p>
                                            <p><a href="sites" class="btn">Ver �</a></p>
                                        </div>
                                        <div class="span4">
                                            <h2>Logros</h2>
                                            <ul class="thumbnails">
                                                <li class="span4"><a class="thumbnail" href="tutorials">
                                                        <img alt="" src="images/logros.png"></a></li></ul>        
                                            <p>Como una forma de propiciar su relaci�n con el entorno, la Facultad de Odontolog�a realiza su proyecci�n a trav�s de una serie de actividades de impacto social, dentro y fuera de su  planta f�sica.</p>
                                            <p><a href="tutorials" class="btn">Ver �</a></p>
                                        </div>
                                        <div class="span4">
                                            <h2>Objetivos</h2>
                                            <ul class="thumbnails">
                                                <li class="span4">
                                                    <a class="thumbnail" href="code">
                                                        <img alt="" src="images/boca.jpg"></a></li></ul>        
                                            <p>Formar de manera integral Odont�logos especialistas en el �rea de Estomatolog�a y Cirug�a Oral que suplan las necesidades en las zonas rurales y urbanas, en cuanto a  la resoluci�n de patolog�as del sistema estomatogn�tico, logrando reducir as� las incidencias de estas alteraciones y sus consecuencia.</p>
                                            <p><a href="code" class="btn">Ver �</a></p>
                                        </div>
                                    </div>
                                    <footer>
                                        <hr>
                                            <p class="left">&copy; Universidad de Cartagena 2012</p>

                                    </footer>
                                </div> <!-- /container -->
                                <div class="modal hide fade" id="myModalRegistro">
                                    <div class="modal-header">
                                        <a data-dismiss="modal" class="close">�</a>
                                        <h3>Registro</h3>
                                    </div>
                                    <div class="modal-body">
                                        <form id="registro" class="form-horizontal">
                                            <fieldset>
                                                <div class="control-group">
                                                    <label for="cedula" class="control-label">Cedula</label>
                                                    <div class="controls">
                                                        <input type="text" id="input01" class="input-xlarge {required:true}" name="cedula">
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label for="nombre" class="control-label">Nombre</label>
                                                    <div class="controls">
                                                        <input type="text" id="nombre" class="input-xlarge {required:true}" name="nombre">
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label for="direccion" class="control-label">Direccion</label>
                                                    <div class="controls">
                                                        <input type="text" id="direccion" class="input-xlarge {required:true}" name="direccion">
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label for="telefono" class="control-label">Telefono</label>
                                                    <div class="controls">
                                                        <input type="text" id="telefono" class="input-xlarge {required:true}" name="telefono">
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label for="anio" class="control-label">A�o</label>
                                                    <div class="controls">
                                                        <select name="anio" class="{required:true}">
                                                            <option selected="selected"></option>
                                                            <option value="1978">1978</option>
                                                            <option value="1979">1979</option>
                                                            <option value="1980">1980</option>
                                                            <option value="1981">1981</option>
                                                            <option value="1982">1982</option>
                                                            <option value="1983">1983</option>
                                                            <option value="1984">1984</option>
                                                            <option value="1985">1985</option>
                                                            <option value="1986">1986</option>
                                                            <option value="1987">1987</option>
                                                            <option value="1988">1988</option>
                                                            <option value="1989">1989</option>
                                                            <option value="1990">1990</option>
                                                            <option value="1991">1991</option>
                                                            <option value="1992">1992</option>
                                                            <option value="1993">1993</option>
                                                            <option value="1994">1994</option>
                                                            <option value="1995">1995</option>
                                                            <option value="1996">1996</option>
                                                            <option value="1997">1997</option>
                                                            <option value="1998">1998</option>
                                                            <option value="1999">1999</option>
                                                            <option value="2000">2000</option>
                                                            <option value="2001">2001</option>
                                                            <option value="2002">2002</option>
                                                            <option value="2003">2003</option>
                                                            <option value="2004">2004</option>
                                                            <option value="2005">2005</option>
                                                            <option value="2006">2006</option>
                                                            <option value="2007">2007</option>
                                                            <option value="2008">2008</option>
                                                            <option value="2009">2009</option>
                                                            <option value="2010">2010</option>
                                                            <option value="2011">2011</option>
                                                            <option value="2012">2012</option>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label for="periodo" class="control-label">Periodo</label>
                                                    <div class="controls">
                                                        <select name="periodo" class="{required:true}">
                                                            <option selected="selected"></option> 
                                                            <option>01</option> 
                                                            <option>02</option> 
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label for="docente" class="control-label">Docente</label>
                                                    <div class="controls">
                                                        <select name="docente" class="{required:true}">
                                                            <option selected="selected"></option> 
                                                            <c:set var="docentes" value="<%=new DocenteJpaController().findDocenteEntities()%>"></c:set>
                                                            <c:forEach items="${docentes}" var="row" varStatus="iter">
                                                                <option value="${row.iddocente}">${row.nombre}</option>    
                                                            </c:forEach>

                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="control-group">
                                                    <label for="codigo" class="control-label">Codigo</label>
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
                            </body>
                            </html>