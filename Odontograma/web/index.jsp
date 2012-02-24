<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Odontograma</title>
   
    <link href="assets/css/bootstrap.css" rel="stylesheet"> 
    <link href="assets/css/docs.css" rel="stylesheet"> 
    

    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">

    
  </head>

  <body>
	



    <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">Odontogramas</a>
          <div class="nav-collapse">
            <ul class="nav">
              <li class="active"><a href="#">Inicio</a></li>
              <li><a href="#about">Acerca de</a></li>
              <li><a href="#contact">Contactenos</a></li>
            </ul>
          
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row-fluid">
        <div class="span3">
          <div class="well sidebar-nav">
            <ul class="nav nav-list">
              <li class="nav-header">Sidebar</li>
              <li class="active"><a href="#formulario1">Formulario 1</a></li>
              <li><a href="#formulario2">Formulario 2</a></li>
              <li><a href="#formulario3">Formulario 3</a></li>
              <li><a href="#formulario4">Formulario 4</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
        <div class="span9" id="formulario1">
          <div class="hero-unit">
            <ul id="tab" class="nav nav-tabs">
            <li ><a href="#home" data-toggle="tab">I. Datos Personales</a></li>
            <li ><a href="#profile" data-toggle="tab">II. Datos Personales</a></li>
            <li class="active"><a href="#otro" data-toggle="tab">III. Examen Fisico Estomatologico</a></li>
           </ul>
          
          <!-------------PESTAÃ‘A 1--------------------------------------------->
          <div id="myTabContent" class="tab-content">
          <div class="tab-pane fade" id="home">
             
             <!--nuevo-->
      		<div class="row">
             <div class="span12">
       
           <form class="form-horizontal">
        <fieldset>
          <legend>I. Datos Personales</legend>
          <div class="control-group">
            <label for="input01" class="control-label">Nombre</label>
            <div class="controls">
              <input type="text" id="input01" class="input-xlarge">
            </div>
          </div>
          <div class="control-group">
            <label for="input04" class="control-label">Direccion</label>
            <div class="controls">
              <input type="text" id="input04" class="input-xlarge">
            </div>
          </div>
          <div class="control-group">
            <label for="input02" class="control-label">No de Identificacion</label>
            <div class="controls">
              <input type="text" id="input02">
            </div>
          </div>
          <div class="control-group">
            <label for="input03" class="control-label">No de Afiliacion</label>
            <div class="controls">
              <input type="text" id="input03">
            </div>
          </div>
          
          <div class="control-group">
            <label for="input05" class="control-label">Telefono</label>
            <div class="controls">
              <input type="text" id="input05">
            </div>
          </div>
          <div class="control-group">
            <label for="input06" class="control-label">Ciudad/Departamento</label>
            <div class="controls">
              <input type="text" id="input06">
            </div>
          </div>
          <div class="control-group">
            <label for="fecha" class="control-label">Fecha</label>
            <div class="controls">
              <input type="text" id="fecha" class="input-small" data-datepicker="datepicker">
            </div>
          </div>
          
          <div class="control-group">
            <label for="input08" class="control-label">Edad</label>
            <div class="controls">
              <input type="text" id="input08" class="input-small">
            </div>
          </div>
          
          <div class="control-group">
            <label class="control-label">Sexo</label>
            <div class="controls">
              <label class="radio inline">
                <input type="radio" value="option1" name="sexo" >
                Hombre
              </label>
              <label class="radio inline">
                <input type="radio" value="option2" name="sexo" >
                Mujer
              </label>
            </div>
          </div>
          
          <div class="control-group">
            <label class="control-label">Estado Civil</label>
            <div class="controls">
              <label class="radio inline">
                <input type="radio" value="option1" name="estadoCivil" >
                Soltero
              </label>
            
              <label class="radio inline">
                <input type="radio" value="option2" name="estadoCivil" >
                Casado
              </label>
           
              <label class="radio inline">
                <input type="radio" value="option3" name="estadoCivil" >
                otro
              </label>
            </div>
          </div>
          <div class="control-group">
            <label for="input09" class="control-label">Ocupacion/Profesion</label>
            <div class="controls">
              <input type="text" id="input09">
            </div>
          </div> 
          
          <div class="control-group">
            <label for="textarea" class="control-label">Remitido a</label>
            <div class="controls">
              <textarea rows="3" id="textarea" class="input-xlarge"></textarea>
            </div>
          </div>       
         
         
          <div class="form-actions">
            <button class="btn btn-primary" type="submit">Guardar cambios</button>
            <button class="btn" type="reset">Cancelar</button>
          </div>
        </fieldset>
      </form>
       		 </div> <!--/span-->
           </div><!--/row-->  
             <!--/nuevo-->
             
            </div>
            
            
            
            <!------------------PESTAÃ‘A 2------------------------------------------>
             <div class="tab-pane fade " id="profile">
             <!--nuevo2-->
             <div class="row">
             <div class="span12">
             <form class="form-horizontal">
              <fieldset>
          <legend>II. Datos Personales</legend>
          <div class="control-group">
            <label for="textarea02" class="control-label">Motivo de la consulta</label>
            <div class="controls">
              <textarea rows="3" id="textarea02" class="input-xxlarge"></textarea>
            </div>
          </div>
          <div class="control-group">
            <label for="textarea03" class="control-label">Historia de la enfermedad actual</label>
            <div class="controls">
              <textarea rows="3" id="textarea03" class="input-xxlarge"></textarea>
            </div>
          </div>       
         <table class="table table-striped table-bordered table-condensed">
        <thead>
          <tr>
            <th>Datos Basicos</th>
            <th>Si</th>
            <th>No</th>
            <th>No Sabe</th>
            <th>Datos Basicos</th>
            <th>Si</th>
            <th>No</th>
            <th>No Sabe</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Tratamiento Medico</td>
            <td> <input type="radio" value="option1" name="Tratamiento" ></td>
            <td> <input type="radio" value="option1" name="Tratamiento" ></td>
            <td> <input type="radio" value="option1" name="Tratamiento" ></td>
            
            <td>Diabetes</td>
            <td> <input type="radio" value="option1" name="Diabetes" ></td>
            <td> <input type="radio" value="option1" name="Diabetes" ></td>
            <td> <input type="radio" value="option1" name="Diabetes" ></td>
          </tr>
          <tr>
            <td>Ingestion Medicamentos</td>
            <td> <input type="radio" value="option1" name="Ingestion" ></td>
            <td> <input type="radio" value="option1" name="Ingestion" ></td>
            <td> <input type="radio" value="option1" name="Ingestion" ></td>
            
            <td>Fiebre Reumatica</td>
            <td> <input type="radio" value="option1" name="Fiebre" ></td>
            <td> <input type="radio" value="option1" name="Fiebre" ></td>
            <td> <input type="radio" value="option1" name="Fiebre" ></td>
          </tr>
          <tr>
           <td>Reacciones Alergicas</td>
            <td> <input type="radio" value="option1" name="Reacciones" ></td>
            <td> <input type="radio" value="option1" name="Reacciones" ></td>
            <td> <input type="radio" value="option1" name="Reacciones" ></td>
            
            <td>Hepatitia</td>
            <td> <input type="radio" value="option1" name="Hepatitia" ></td>
            <td> <input type="radio" value="option1" name="Hepatitia" ></td>
            <td> <input type="radio" value="option1" name="Hepatitia" ></td>
          </tr>
          <tr>
           <td>Anestesia </td>
            <td> <input type="radio" value="option1" name="Anestesia" ></td>
            <td> <input type="radio" value="option1" name="Anestesia" ></td>
            <td> <input type="radio" value="option1" name="Anestesia" ></td>
            
            <td>Hipertension</td>
            <td> <input type="radio" value="option1" name="Hipertension" ></td>
            <td> <input type="radio" value="option1" name="Hipertension" ></td>
            <td> <input type="radio" value="option1" name="Hipertension" ></td>
          </tr>
          <tr>
           <td>Antibioticos </td>
            <td> <input type="radio" value="option1" name="Antibioticos" ></td>
            <td> <input type="radio" value="option1" name="Antibioticos" ></td>
            <td> <input type="radio" value="option1" name="Antibioticos" ></td>
            
            <td>Embarazo</td>
            <td> <input type="radio" value="option1" name="Embarazo" ></td>
            <td> <input type="radio" value="option1" name="Embarazo" ></td>
            <td> <input type="radio" value="option1" name="Embarazo" ></td>
          </tr>
          <td>Hemorragias</td>
            <td> <input type="radio" value="option1" name="Hemorragias" ></td>
            <td> <input type="radio" value="option1" name="Hemorragias" ></td>
            <td> <input type="radio" value="option1" name="Hemorragias" ></td>
            
            <td>Enfermedades Renales</td>
            <td> <input type="radio" value="option1" name="Renales" ></td>
            <td> <input type="radio" value="option1" name="Renales" ></td>
            <td> <input type="radio" value="option1" name="Renales" ></td>
          </tr>
          <td>Irradiaciones</td>
            <td> <input type="radio" value="option1" name="Irradiaciones" ></td>
            <td> <input type="radio" value="option1" name="Irradiaciones" ></td>
            <td> <input type="radio" value="option1" name="Irradiaciones" ></td>
            
            <td>Enfermedades Gastroinstestinales</td>
            <td> <input type="radio" value="option1" name="Gastroinstestinales" ></td>
            <td> <input type="radio" value="option1" name="Gastroinstestinales" ></td>
            <td> <input type="radio" value="option1" name="Gastroinstestinales" ></td>
          </tr>
          <td>Sinusitis</td>
            <td> <input type="radio" value="option1" name="Sinusitis" ></td>
            <td> <input type="radio" value="option1" name="Sinusitis" ></td>
            <td> <input type="radio" value="option1" name="Sinusitis" ></td>
            
            <td>Organos de los Sentidos</td>
            <td> <input type="radio" value="option1" name="Sentidos" ></td>
            <td> <input type="radio" value="option1" name="Sentidos" ></td>
            <td> <input type="radio" value="option1" name="Sentidos" ></td>
          </tr>
          
          <td>Enfermedades Respiratorias</td>
            <td> <input type="radio" value="option1" name="Respiratorias" ></td>
            <td> <input type="radio" value="option1" name="Respiratorias" ></td>
            <td> <input type="radio" value="option1" name="Respiratorias" ></td>
            
            <td>Enfermedades Infectocontagiosas</td>
            <td> <input type="radio" value="option1" name="Infectocontagiosas" ></td>
            <td> <input type="radio" value="option1" name="Infectocontagiosas" ></td>
            <td> <input type="radio" value="option1" name="Infectocontagiosas" ></td>
          </tr>
          <td>Cardiopatias</td>
            <td> <input type="radio" value="option1" name="Cardiopatias" ></td>
            <td> <input type="radio" value="option1" name="Cardiopatias" ></td>
            <td> <input type="radio" value="option1" name="Cardiopatias" ></td>
            <td colspan="4"></td>
          </tr>
        </tbody>
        </table>
        
        
        <div class="control-group">
            <label for="textareaObs" class="control-label">Observaciones</label>
            <div class="controls">
              <textarea rows="3" id="textareaObs" class="input-xxlarge"></textarea>
            </div>
        </div>
        <div class="control-group">
            <label for="Otros" class="control-label">Otros</label>
            <div class="controls">
              <textarea rows="3" id="Otros" class="input-xxlarge"></textarea>
            </div>
        </div>
        <div class="control-group">
          <label for="ultima" class="control-label">Ultima Visita al odontologo</label>
            <div class="controls">
              <input type="text" id="ultima" class="input-medium" data-datepicker="datepicker">
        	</div>
        </div>
            
        <div class="control-group">
          <label for="motivo" class="control-label">Motivo</label>
            <div class="controls">
			<textarea rows="3" id="motivo" class="input-xxlarge"></textarea>
        	</div>
         </div>
         
         <div class="form-actions">
            <button class="btn btn-primary" type="submit">Guardar cambios</button>
            <button class="btn" type="reset">Cancelar</button>
          </div>
        </fieldset>
      </form>
      		</div> <!--/span-->
           </div><!--/row-->  
             <!--/nuevo2-->
             
            </div>
            
            
            
            <!-----------------PESTAÃ‘A 3---------------------------->
            <div class="tab-pane fade in active" id="otro">
              <div class="row">
              
            	 <form class="form-horizontal">
              		<fieldset>
			          <legend>III. Examen Fisico Estomatologico</legend>
          				<div class="control-group">
			            <label for="temperatura" class="control-label">Temperatura</label>
            				<div class="controls">
		              		<input id="temperatura"  type="text" >
            				</div>
          				</div>
                        <div class="control-group">
			            <label for="pulso" class="control-label">Pulso</label>
            				<div class="controls">
		              		<input id="pulso"  type="text" >
            				</div>
          				</div>
                        <div class="control-group">
			            <label for="tension" class="control-label">Tension A.</label>
            				<div class="controls">
		              		<input id="tension"  type="text" >
            				</div>
          				</div>
                       <div class="control-group">
			            <label for="respiracion" class="control-label">Respiracion</label>
            				<div class="controls">
		              		<input id="respiracion"  type="text" >
            				</div>
          				</div>
                       	<div class="control-group">
            				<label class="control-label">Higiene Oral</label>
            					<div class="controls">
              					<select id="seda">
                					<option>Buena</option>
					                <option>Regular</option>
					                <option>Mala</option>
               						</select>
            					</div>
						</div>
                        <div class="control-group">
            				<label class="control-label">Seda Dental</label>
            					<div class="controls">
              						<select id="seda">
                					<option>Si</option>
					                <option>No</option>
					                <option>Aveces</option>
               						</select>
            					</div>
						</div>
                         <div class="control-group">
            				<label class="control-label">Cepillo dental:Uso</label>
            					<div class="controls">
              						<select id="seda">
                					<option>Si</option>
					                <option>No</option>
               						</select>
            					</div>
                         </div>
                         <div class="control-group">
            				<label class="control-label">Cuantas veces al dia</label>
            					<div class="controls">
              						<input id="veces"  type="text" >
            					</div>
                         </div>
                         <div class="control-group">
            				<label class="control-label">Tiempo</label>
            					<div class="controls">
              						<input id="tiempo"  type="text" >
            					</div>
                         </div>
                         <div class="control-group">
            				<label class="control-label">Enjuages Bucales sin fluor</label>
            					<div class="controls">
              						<select id="enjuages">
                					<option>Si</option>
					                <option>No</option>
									<option>Aveces</option>
               						</select>
            					</div>
                         </div>
                         <div class="control-group">
            				<label class="control-label">Enjuages Bucales con fluor</label>
            					<div class="controls">
              						<select id="enjuages">
                					<option>Si</option>
					                <option>No</option>
									<option>Aveces</option>
               						</select>
            					</div>
                         </div>
                         <div class="control-group">
            				<label class="control-label">Habitos y vicios</label>
            					<div class="controls">
              						<textarea rows="3" class="input-xxlarge" id="habitos"></textarea>
            					</div>
                         </div>
                         <div class="form-actions">
            				<button class="btn btn-primary" type="submit">Guardar cambios</button>
				            <button class="btn" type="reset">Cancelar</button>
          				</div>
          			</fieldset>
      			</form>
              <div class="span12">
              </div><!--span12--> 
              </div><!--row-->
            </div>
             
            
          </div>

          </div>
         
          
        </div><!--/span-->
        
        <div class="span9" id="formulario2" style="display: none;">
            <div class="hero-unit">
                <div class="row">
                    <div class="span12">
                        <form class="form-horizontal">
                            <fieldset>
                                <legend>Diagnosticos</legend>
                                
                                <table class="table table-striped table-bordered table-condensed" id="tablaDiag" >
                                    <thead>
                                        <tr>
                                            <th>Diagnosticos</th>
                                            <th>Codigo</th>
                                                
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><textarea rows="3" id="textarea02" class="input-xxlarge"></textarea></td>
                                            <td> <input type="text" name="codigo" class="input-medium"></td>
                                        </tr>    
                                    </tbody>
                                </table>
                                
                                    <button class="btn" type="button" id="agregarDiag">Agregar Diagnostico</button>
                                
                            </fieldset>        
                                   <br> 
                                <fieldset>
                                <legend>Pronostico</legend>    
                                <div class="control-group">
                                    <label class="control-label">Pronostico</label>
                                    <div class="controls">
                                        <label class="radio inline">
                                            <input type="radio" value="option1" name="pronostico" >
                                            Bueno
                                        </label>
                                        <label class="radio inline">
                                            <input type="radio" value="option2" name="pronostico" >
                                            Regular
                                        </label>
                                        <label class="radio inline">
                                            <input type="radio" value="option2" name="pronostico" >
                                            Malo
                                        </label>
                                    </div>
                                </div>
                                
                            </fieldset>
                                   
                                    <br> 
                                <fieldset>
                                <legend>Plan de tratamiento</legend>  
                                
                                    <label class="checkbox">
                                        <input type="checkbox"> Promocion y Prevencion
                                    </label>
                                    <label class="checkbox">
                                        <input type="checkbox"> operatoria
                                    </label>
                                    <label class="checkbox">
                                        <input type="checkbox"> endodoncia
                                    </label>
                                    <label class="checkbox">
                                        <input type="checkbox"> periodoncia
                                    </label>
                                    <label class="checkbox">
                                        <input type="checkbox"> cirujia
                                    </label>
                                    <label class="checkbox">
                                        <input type="checkbox"> rehabilitacion
                                    </label>
                                    <label class="checkbox">
                                        <input type="checkbox"> ortodoncia
                                    </label>
                                    <label class="checkbox">
                                        <input type="checkbox"> Otros
                                    </label>
                               
                                </fieldset> 
                                   <br>
                                   <fieldset>
                                <legend>Tratamiento</legend>
                                
                                <table class="table table-striped table-bordered table-condensed" id="tablaTrat" >
                                    <thead>
                                        <tr>
                                            <th>Tratamiento</th>
                                            <th>Presupuesto</th>
                                                
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><textarea rows="3" id="textarea02" class="input-xxlarge"></textarea></td>
                                            <td> <input type="text" name="codigo" class="input-medium"></td>
                                        </tr>    
                                    </tbody>
                                </table>
                                
                                    <button class="btn" type="button" id="agregarTrat">Agregar Tratamiento</button>
                                
                            </fieldset>   
                                   <br>
                                   <fieldset>
                                <legend>Evolucion</legend>
                                
                                <table class="table table-striped table-bordered table-condensed" id="tablaTrat" >
                                    <thead>
                                        <tr>
                                            <th>Fecha</th>
                                            <th>#Recibo Pago</th>
                                            <th>Tratamiento Ejecutado</th>
                                                  
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><input type="text" name="fecha" class="input-medium" data-datepicker="datepicker"></td>
                                            <td><input type="text" name="recibo" class="input-medium"></td>
                                            <td><textarea rows="3" id="textarea02" class="input-xxlarge"></textarea></td>
                                            </tr>    
                                    </tbody>
                                </table>
                                
                                    <button class="btn" type="button" id="agregarEvol">Agregar Evolucion</button>
                                
                            </fieldset>
                                   
                                   <div class="form-actions">
                                       <button class="btn btn-primary" type="submit">Guardar cambios</button>
                                       <button class="btn" type="reset">Cancelar</button>
                                   </div>
                        </form>
                        
                       
                    </div>
                </div>
           </div>
        </div>
        
      </div><!--/row-->

      

      <footer>
        <p>&copy; Universidad de Cartagena 2012</p>
      </footer>

    </div><!--/.fluid-container-->
    
    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap-transition.js"></script>
    <script src="assets/js/bootstrap-alert.js"></script>
    <script src="assets/js/bootstrap-modal.js"></script>
    <script src="assets/js/bootstrap-dropdown.js"></script>
    <script src="assets/js/bootstrap-scrollspy.js"></script>
    <script src="assets/js/bootstrap-tab.js"></script>
    <script src="assets/js/bootstrap-tooltip.js"></script>
    <script src="assets/js/bootstrap-popover.js"></script>
    <script src="assets/js/bootstrap-button.js"></script>
    <script src="assets/js/bootstrap-collapse.js"></script>
    <script src="assets/js/bootstrap-carousel.js"></script>
    <script src="assets/js/bootstrap-typeahead.js"></script>
    <script src="assets/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
        $(function(){
            $(".nav-list >li > a").click(function(ja){
                ja.preventDefault();
                ja.stopPropagation();
                $(this).parents("li").siblings().removeClass("active");
                $(this).parents("li").addClass("active");
             $('[id^=formulario]').hide();
                var div = $(this).attr("href");
                $(div).show();
                
        });
            
            $("#agregarDiag").click(function(){
             $("#tablaDiag").append("<tr>"
                                            +"<td><textarea rows='3' id='textarea02' class='input-xxlarge'></textarea></td>"
                                            +"<td> <input type='text' name='codigo' class='input-medium'></td>"
                                        +"</tr>  ");
            }) 
            $("#agregarTrat").click(function(){
             $("#tablaTrat").append("<tr>"
                                            +"<td><textarea rows='3' id='textarea02' class='input-xxlarge'></textarea></td>"
                                            +"<td> <input type='text' name='codigo' class='input-medium'></td>"
                                        +"</tr>  ");
            }) 
        });
    </script>
   	
  </body>
</html>
