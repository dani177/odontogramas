<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src='<%=request.getContextPath()%>/js/jquery.reel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.disabletextselect-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.mousewheel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.cookie-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/sampler.js' type='text/javascript'></script>
<style type="text/css">
    .diente{
        cursor: pointer;
    }
</style>
<script type="text/javascript">
    $(function(){
   
        $('.ultima').datepicker();        
        $('.fecha').datepicker();        
        
        $(".diente").click(function(ev){
            if($("#derecha").css("display")=="none"){
                $("#derecha").show();
            }
            $("#dienteSeleccionado").text("Diente "+ $(this).attr("id"));
        });
        
        $(".parte").click(function(ev){
            alert($(this).attr("id"));
        });
        
        
        $("#agregarEvol").click(function(){
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarEvolucion",
                data: $("#formEvol").serialize(),
                success: function(){
                    $("#tablaEvol").prepend("<tr>"
                        +"<td>"+$("#fechaE").val()+"</td>"
                        +"<td>"+$("#reciboE").val()+"</td>"
                        +"<td>"+$("#tratamientoE").val()+"</td>"
                        +"<td>"+$("#codigoTratE").val()+"</td>"
                        +"</tr>  ");
                    $("fechaE").val("");
                    $("#reciboE").val("");
                    $("#tratamientoE").val("");
                    $("#codigoTratE").val("");
                    
                } //fin success
            }); //fin $.ajax    
            
        }) ;
        $("#guardarDiag").click(function(){
            $(this).button('loading');
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarDiagnostico",
                data: "diagnosticos="+$("#formDiag input[name='hidden-tags']").val(),
                success: function(){
                    setTimeout(function(){
                        $("#guardarDiag").button('reset');
                    }, 500);
                    
                } //fin success
            }); //fin $.ajax    
        
        }) ;

      
        
        
        $("#guardarProno").click(function(){
            $(this).button('loading');
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarPronostico",
                data: $("#formPron").serialize(),
                success: function(){
                    setTimeout(function(){
                        $("#guardarProno").button('reset');
                    }, 500);
                    
                } //fin success
            }); //fin $.ajax    
        
        }) ;


        $("#guardarOtros").click(function(){
            $(this).button('loading');
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarOtros",
                data: ""+$("#formOtros").serialize(),
                success: function(){
                    setTimeout(function(){
                        $("#guardarOtros").button('reset');
                    }, 500);
                    
                } //fin success
            }); //fin $.ajax    
        
        }) ;

        
        $("#guardarTrat").click(function(){
            $(this).button('loading');
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarTratamiento",
                data: "tratamientos="+$("#formTrata input[name='hidden-tags2']").val(),
                success: function(){
                    setTimeout(function(){
                        $("#guardarTrat").button('reset');
                    }, 500);
                    
                } //fin success
            }); //fin $.ajax    
           
        }) ;

        
        
        var miArray2 = new Array(${tratamientos.getRowCount()});
        
    <c:forEach items="${tratamientos.rowsByIndex}" var="item2" varStatus="iter2">
            miArray2[${iter2.index}] = "${item2[1]} - ${item2[0]} - ${item2[2]}";
    </c:forEach> 
        
            $(".tagManager2").tagsManager({
                prefilled: null,
                CapitalizeFirstLetter: false,
                preventSubmitOnEnter: true,
                typeahead: true,
                typeaheadAjaxSource: null,
                typeaheadSource: miArray2,
                delimeters: [44, 188, 13],
                backspace: [8],
                blinkBGColor_1: '#FFFF9C',
                blinkBGColor_2: '#CDE69C'
            });
    
            $("#formTrata input[name='hidden-tags2']").change(function(){
                var tratamiento = $("input[name='hidden-tags2']").val();
                var presupuesto = 0;
                if(tratamiento!=""){
                    var tratamientos = tratamiento.split(",");
                    for(var i=0;i<tratamientos.length;i++){
                        var aux=  tratamientos[i].split("-");
                        presupuesto+=parseInt(aux[2]);
                    }
                }
                $("#tagpresupuesto").val(presupuesto);
            });
        
            var miArray = new Array(${diagnosticos.getRowCount()});
        
    <c:forEach items="${diagnosticos.rowsByIndex}" var="item" varStatus="iter">
            miArray[${iter.index}] = "${item[2]} - ${item[0]}";
    </c:forEach> 
    
            $(".tagManager").tagsManager({
                prefilled: null,
                CapitalizeFirstLetter: false,
                preventSubmitOnEnter: true,
                typeahead: true,
                typeaheadAjaxSource: null,
                typeaheadSource: miArray,
                delimeters: [44, 188, 13],
                backspace: [8],
                blinkBGColor_1: '#FFFF9C',
                blinkBGColor_2: '#CDE69C'
            });
            $("#formDiag input[name='hidden-tags']").change(function(){
               
            });
            
            $("#datos2").validate({
                submitHandler: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "<%=request.getContextPath()%>/formController?action=guardarDatosBasicos",
                        data: $("#datos2").serialize(),
                        success: function(){
                            $("a[href='#otro']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });    
            
            $("#formPron").validate({
                submitHandler: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "<%=request.getContextPath()%>/formController?action=guardarPron",
                        data: $("#formPron").serialize(),
                        success: function(){
                            // $("a[href='#otro']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });    
            
            
            
            $("#datos3").validate({
                submitHandler: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "<%=request.getContextPath()%>/formController?action=guardarDatosBasicos2",
                        data: $("#datos3").serialize(),
                        success: function(){
                            $("a[href='#diag']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });    
            
            
            
            $.reel.def.indicator= 5;

            $('.sample img[id]').each(function(){

                prepare_reel_sample('#' + $(this).attr('id'));
                /*
    This `prepare_reel_sample` essentialy uses each sample's options
    and passes them to `.reel` call as a parameter when clicked.
    It also adds some UI interactions like toggling samples, cookie persistence and such.
    Definitely not needed for running Reel itself. You DON'T want to use it.

    You simply do:
      $('#my_image').reel({ ..your options.. });

    Just like that.
                 */
            });

            /*
  Cookie persistence of last selected sample. You DON'T want to use this either.
             */
            $($.cookie('reel.test.sample') || '.sample:first').click();

            
            
        }); //fin function
</script>


<%@page contentType="text/html" pageEncoding="UTF-8"%>


<div>
    <ul id="tab" class="nav nav-tabs">
        <li class="active"><a href="#profile" data-toggle="tab">I. Datos Basicos</a></li>
        <li ><a href="#otro" data-toggle="tab">II. Examen Fisico Estomatologico</a></li>
        <li ><a href="#odonto" data-toggle="tab">III. Odontograma</a></li>
        <li ><a href="#diag" data-toggle="tab">IV. Diagnostico Y Tratamiento </a></li>
    </ul>




    <!-------------PESTANA 1--------------------------------------------->
    <div id="myTabContent" class="tab-content">
        <!------------------PESTANA 2------------------------------------------>
        <div class="tab-pane fade in active " id="profile">
            <!--nuevo2-->

            <div class="span12">
                <form class="form-horizontal" id="datos2" method="post">
                    <fieldset>
                        <legend>II. Datos Personales</legend>
                        <div class="control-group">
                            <label for="motivo" class="control-label">Motivo de la consulta</label>
                            <div class="controls">
                                <textarea rows="3" id="motivo" name="motivo" class="input-xxlarge {required:true}">${consulta.getRowsByIndex()[0][1]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="historia" class="control-label">Historia de la enfermedad actual</label>
                            <div class="controls">
                                <textarea rows="3" id="historia" name="historia" class="input-xxlarge {required:true}">${consulta.getRowsByIndex()[0][2]}</textarea>
                            </div>
                        </div>       
                        <table class="table table-striped table-bordered table-condensed">
                            <thead>
                                <tr>
                                    <th>Datos Basicos</th>
                                    <th>Si</th>
                                    <th>No</th>
                                    <th>No Sabe</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${datosconsultaHasDatosbasicos.rowsByIndex}" var="row">
                                    <tr>
                                        <td>${row[5]}</td>
                                        <c:choose>
                                            <c:when test="${row[2]=='si'}">
                                                <td> <input type="radio" value="si" name="db${row[1]}" checked=""></td>
                                                </c:when>
                                                <c:otherwise>
                                                <td> <input type="radio" value="si" name="db${row[1]}"></td>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test="${row[2]=='no'}">
                                                <td> <input type="radio" value="no" name="db${row[1]}" checked=""></td>
                                                </c:when>
                                                <c:otherwise>
                                                <td> <input type="radio" value="no" name="db${row[1]}" ></td>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:choose>
                                                <c:when test='${row[2]=="no sabe"}'>
                                                <td> <input type="radio" value="no sabe" name="db${row[1]}" checked=""></td>
                                                </c:when>
                                                <c:otherwise>
                                                <td> <input type="radio" value="no sabe" name="db${row[1]}"></td>
                                                </c:otherwise>
                                            </c:choose>

                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>


                        <div class="control-group">
                            <label for="observaciones" class="control-label">Observaciones</label>
                            <div class="controls">
                                <textarea rows="3" id="observaciones" name="observaciones" class="input-xxlarge  {required:true}">${consulta.getRowsByIndex()[0][3]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="otros" class="control-label">Otros</label>
                            <div class="controls">
                                <textarea rows="3" id="otros" name="otros" class="input-xxlarge">${consulta.getRowsByIndex()[0][4]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="ultima" class="control-label">Ultima Visita al odontologo</label>
                            <div class="controls">
                                <input type="text" id="ultima" name="ultima" class="input-medium ultima" data-datepicker="datepicker" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${consulta.getRowsByIndex()[0][5]}'></fmt:formatDate>" />
                            </div>
                        </div>

                        <div class="control-group">
                            <label for="motivo2" class="control-label">Motivo</label>
                            <div class="controls">
                                <textarea rows="3" id="motivo2" name="motivo2" class="input-xxlarge">${consulta.getRowsByIndex()[0][6]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="docentes" class="control-label">Docente</label>
                            <div class="controls">
                                <select name="docente" class="{required:true}">
                                    <option selected="selected"></option> 
                                    <c:forEach items="${docentes.rowsByIndex}" var="row" varStatus="iter">
                                        <c:choose>
                                            <c:when test="${consulta.getRowsByIndex()[0][11]==row[0]}">
                                                <option selected="selected" value="${row[0]}">${row[1]}</option>            
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${row[0]}">${row[1]}</option>            
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>

                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button class="btn btn-primary" type="submit">Guardar cambios</button>
                            <button class="btn" type="reset">Cancelar</button>
                        </div>
                    </fieldset>
                </form>
            </div> <!--/span-->

            <!--/nuevo2-->

        </div>



        <!-----------------PESTANA 3---------------------------->
        <div class="tab-pane fade" id="otro">

            <div class="span12">
                <form class="form-horizontal" id="datos3">
                    <fieldset>
                        <legend>III. Examen Fisico Estomatologico</legend>
                        <div class="control-group">
                            <label for="temperatura" class="control-label">Temperatura</label>
                            <div class="controls">
                                <input id="temperatura"  name="temperatura" type="text" value="${examenfisicoestomatologicoList.getRowsByIndex()[0][1]}">
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="pulso" class="control-label">Pulso</label>
                            <div class="controls">
                                <input id="pulso" name="pulso"  type="text" value="${examenfisicoestomatologicoList.getRowsByIndex()[0][2]}">
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="tension" class="control-label">Tension A.</label>
                            <div class="controls">
                                <input id="tension" name="tension" type="text" value="${examenfisicoestomatologicoList.getRowsByIndex()[0][3]}" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Higiene Oral</label>
                            <div class="controls">
                                <select id="higiene" name="higiene">
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][4] == "Buena"}'>
                                            <option selected="selected" value="Buena">Buena</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Buena">Buena</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][4] == "Regular"}'>
                                            <option selected="selected" value="Regular">Regular</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Regular">Regular</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][4] == "Mala"}'>
                                            <option selected="selected" value="Mala">Mala</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Mala">Mala</option>
                                        </c:otherwise>

                                    </c:choose>

                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Uso de seda dental</label>
                            <div class="controls">
                                <select id="usoSeda" name="usoSeda">
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][5] == "Si"}'>
                                            <option selected="selected" value="Si">Si</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Si">Si</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][5] == "No"}'>
                                            <option selected="selected" value="No">No</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="No">No</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][5] == "Aveces"}'>
                                            <option selected="selected" value="Aveces">Aveces</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Aveces">Aveces</option>
                                        </c:otherwise>

                                    </c:choose>

                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Cepillo dental:Uso</label>
                            <div class="controls">
                                <select id="cepillo" name="cepillo">
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][6] == "Si"}'>
                                            <option selected="selected" value="Si">Si</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Si">Si</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][6] == "No"}'>
                                            <option selected="selected" value="No">No</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="No">No</option>
                                        </c:otherwise>
                                    </c:choose>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Cuantas veces al dia</label>
                            <div class="controls">
                                <select id="veces" name="veces">
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][7] == "0"}'>
                                            <option selected="" value="0">0</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="0">0</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][7] == "1"}'>
                                            <option selected="" value="1">1</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="1">1</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][7] == "2"}'>
                                            <option selected="" value="2">2</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="2">2</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][7] == "3"}'>
                                            <option selected="" value="3">3</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="3">3</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][7] == "4"}'>
                                            <option selected="" value="4">4</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="4">4</option>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][7] == "5"}'>
                                            <option selected="" value="5">5</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="5">5</option>
                                        </c:otherwise>
                                    </c:choose>


                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Uso de Enjuages Bucales sin fluor</label>
                            <div class="controls">
                                <select id="enjuages1" name="enjuages1">
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][8] == "Si"}'>
                                            <option selected="selected" value="Si">Si</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Si">Si</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][8] == "No"}'>
                                            <option selected="selected" value="No">No</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="No">No</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][8] == "Aveces"}'>
                                            <option selected="selected" value="Aveces">Aveces</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Aveces">Aveces</option>
                                        </c:otherwise>

                                    </c:choose>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"> Uso de Enjuages Bucales con fluor</label>
                            <div class="controls">
                                <select id="enjuages2" name="enjuages2">
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][9] == "Si"}'>
                                            <option selected="selected" value="Si">Si</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Si">Si</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][9] == "No"}'>
                                            <option selected="selected" value="No">No</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="No">No</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][9] == "Aveces"}'>
                                            <option selected="selected" value="Aveces">Aveces</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Aveces">Aveces</option>
                                        </c:otherwise>

                                    </c:choose>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Habitos y vicios</label>
                            <div class="controls">
                                <select id="habitosYvicios" name="habitosYvicios">
                                    <option></option>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Tabacos"}'>
                                            <option selected="selected" value="Tabacos">Tabacos</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Tabacos">Tabacos</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Alcohol"}'>
                                            <option selected="selected" value="Alcohol">Alcohol</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Alcohol">Alcohol</option>
                                        </c:otherwise>

                                    </c:choose>
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Caf&eacute;"}'>
                                            <option selected="selected" value="Caf&eacute;">Caf&eacute;</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Caf&eacute;">Caf&eacute;</option>
                                        </c:otherwise>

                                    </c:choose>

                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Drogas"}'>
                                            <option selected="selected" value="Drogas">Drogas</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Drogas">Drogas</option>
                                        </c:otherwise>

                                    </c:choose>      
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Otro"}'>
                                            <option selected="selected" value="Otro">Otro</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Otro">Otro</option>
                                        </c:otherwise>
                                    </c:choose>  
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Ninguno"}'>
                                            <option selected="selected" value="Ninguno">Ninguno</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Ninguno">Ninguno</option>
                                        </c:otherwise>
                                    </c:choose>  


                                </select>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button class="btn btn-primary" type="submit">Guardar cambios</button>
                            <button class="btn" type="reset">Cancelar</button>
                        </div>

                    </fieldset>
                </form>

            </div><!--span12--> 

        </div>

        <!-----------------PESTANA 4---------------------------->
        <div class="tab-pane fade" id="odonto">
            <div class="span12">
                <form class="form-horizontal" id="odo" method="post">
                    <fieldset>
                        <legend>Odontograma</legend>
                        <div class="row">
                            <div class="span6">   
                                <svg style="width: 600px; height: 600px;" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
                                <image xlink:href="<%=request.getContextPath()%>/images/adultos.gif" height="479" width="340" y="20" x="20"/>
                                <path d="m66.82642,28.81544c0.07912,0 0.23735,0 0.39562,0c0.15826,0 0.32075,-0.042 0.47474,0c0.17221,0.04696 0.30691,0.13652 0.55389,0.18282c0.07809,0.01463 0.31649,0 0.47474,0c0.07913,0 0.31651,0 0.39561,0c0.07914,0 0.23737,0 0.39563,0c0.0791,0 0.31651,0 0.39561,0c0.07914,0 0.2374,0 0.39565,0c0.47475,0 0.55387,0 0.63297,0c0.15825,0 0.39565,0 0.55389,0c0.15825,0 0.31651,0 0.47475,0c0.23736,0 0.39561,0 0.55387,0c0.15825,0 0.31648,0 0.55386,0c0.15826,0 0.31651,0 0.47477,0c0.07912,0 0.15822,0 0.31647,0c0.15826,0 0.29224,0.04193 0.39564,0.09141c0.0731,0.03498 0.15825,0.0914 0.15825,0.36561c0,0.09141 0.04886,0.28118 0.0791,0.36562c0.04285,0.11942 0.17197,0.07794 0.2374,0.18281c0.10345,0.16581 0.11543,0.24618 0.15823,0.36561c0.03027,0.08445 0.07912,0.09141 0.23737,0.09141c0.15826,0 0.39564,-0.09141 0.71212,-0.09141c0.07912,0 0.24339,0.03497 0.31651,0c0.10336,-0.04948 0.23734,-0.0914 0.39561,-0.0914c0.15827,0 0.44197,0.12928 0.55386,0c0.05597,-0.06462 0.15827,-0.09141 0.31652,-0.09141c0.15826,0 0.26477,0.06449 0.39565,0.27422c0.10344,0.16581 0.04633,0.32775 0.15826,0.45702c0.05592,0.06463 0.22339,0.04444 0.39559,0.0914c0.077,0.02101 0.15826,0.0914 0.3165,0.0914c0.23737,0 0.32252,0.05643 0.39563,0.09141c0.10339,0.04947 0.24339,0.14783 0.31651,0.18281c0.10336,0.04947 0.13396,0.13335 0.23735,0.1828c0.07311,0.035 0.2374,0.09141 0.31651,0.09141c0.15823,0 0.32251,0.05644 0.3956,0.09141c0.10339,0.04947 0.14009,0.09385 0.15826,0.1828c0.04066,0.19892 0.08516,0.23925 0.15825,0.27421c0.10339,0.04948 0.07911,0.18283 0.07911,0.27422c0,0.0914 0.03632,0.15479 0.07915,0.27421c0.03026,0.08445 0.07912,0.18281 0.15822,0.27422c0.07915,0.09139 0.11667,0.19646 0.15826,0.27422c0.09303,0.17385 0.30486,0.19861 0.39563,0.27421c0.14355,0.11951 0.08685,0.25816 0.23738,0.36562c0.06729,0.04804 0.18141,0.11816 0.23738,0.18281c0.05591,0.06464 0.04882,0.09835 0.0791,0.1828c0.04283,0.11943 0.04636,0.23636 0.15826,0.36563c0.05593,0.06463 0.07912,0.09141 0.15824,0.18282c0.07913,0.09139 0.07913,0.1828 0.07913,0.27421c0,0.09139 0.07912,0.1828 0.07912,0.36561c0,0.09141 0,0.27421 0,0.3656c0,0.09141 0.11818,0.17173 0.15826,0.45704c0.03802,0.27067 0.01369,0.44356 0.07912,0.54841c0.10344,0.16581 -0.03278,0.41917 0.07911,0.54843c0.05596,0.06464 0.128,0.09837 0.15826,0.18282c0.0428,0.11941 0.19457,0.15478 0.23738,0.27421c0.06059,0.16889 0.02318,0.30098 0.07912,0.36561c0.05595,0.06464 0,0.18282 0,0.27421c0,0.09141 0,0.18282 0,0.27422c0,0.0914 0.15826,0.3656 0.2374,0.45702c0.0791,0.09139 0.09384,0.15471 0.23737,0.2742c0.09075,0.07558 0.07911,0.1828 0.07911,0.36562c0,0.09141 -0.03629,0.1548 -0.07911,0.27422c-0.0303,0.08445 0,0.1828 0,0.54842c0,0.09141 -0.0714,0.25816 0.07911,0.36562c0.06731,0.04804 0.07912,0.0914 0.07912,0.18281c0,0.09141 0,0.54843 0,0.63984c0,0.0914 0.07915,0.2742 0.15826,0.45701c0.07911,0.18281 0.11543,0.24621 0.15826,0.36562c0.06056,0.16889 0,0.27421 0,0.36562c0,0.27421 0,0.36562 0,0.63984c0,0.09139 0,0.2742 0,0.36562c0,0.0914 0.02432,0.29121 -0.07915,0.45702c-0.06541,0.10486 -0.12795,0.28118 -0.15822,0.36562c-0.04285,0.11943 -0.04637,0.23635 -0.15826,0.36561c-0.05595,0.06463 -0.18141,0.02678 -0.23738,0.0914c-0.05595,0.06463 -0.01369,0.35217 -0.0791,0.45703c-0.10347,0.16581 -0.19458,0.33758 -0.2374,0.45702c-0.03026,0.08446 0.02427,0.22475 -0.07912,0.27422c-0.0731,0.03498 -0.10231,0.02677 -0.15823,0.0914c-0.05596,0.06463 -0.01369,0.35216 -0.07915,0.45703c-0.10345,0.16581 -0.07912,0.36561 -0.07912,0.54842c0,0.09142 -0.10229,0.11818 -0.15825,0.18282c-0.05596,0.06462 -0.0928,0.16935 -0.15827,0.27419c-0.10343,0.16581 -0.1814,0.30099 -0.23736,0.36563c-0.05594,0.06462 -0.07912,0.09141 -0.07912,0.27422c0,0.0914 -0.15826,0.27421 -0.15826,0.45702c0,0.0914 -0.10231,0.20958 -0.15822,0.2742c-0.11189,0.12926 -0.09057,0.2682 -0.15828,0.45703c-0.09573,0.26704 -0.10229,0.39239 -0.15826,0.45702c-0.05592,0.06462 -0.10229,0.02677 -0.15823,0.0914c-0.05595,0.06462 0.02424,0.22475 -0.07913,0.27421c-0.0731,0.03499 -0.12797,0.09835 -0.15825,0.18281c-0.04282,0.11942 -0.15825,0.27421 -0.23736,0.27421c-0.15826,0 -0.24921,0.04336 -0.31653,0.0914c-0.15048,0.10746 -0.14428,0.22725 -0.31648,0.27422c-0.07699,0.021 -0.09095,0.04335 -0.15826,0.0914c-0.30101,0.21489 -0.27368,0.33759 -0.31648,0.45701c-0.06055,0.16888 -0.00282,0.41171 -0.23738,0.82265c-0.0616,0.1079 -0.05486,0.22473 -0.15825,0.2742c-0.0731,0.035 -0.09686,0.08253 -0.15823,0.27423c-0.11319,0.35345 -0.19457,0.3376 -0.23737,0.45702c-0.0303,0.08442 -0.07914,0.1828 -0.2374,0.36561c-0.15824,0.1828 -0.23737,0.1828 -0.3165,0.27421c-0.07911,0.09138 -0.16427,0.14781 -0.23737,0.18281c-0.10338,0.04946 -0.14659,0.10722 -0.23738,0.1828c-0.28706,0.23902 -0.47474,0.1828 -0.55385,0.27421c-0.07912,0.0914 -0.15826,0.18281 -0.2374,0.2742c-0.07911,0.0914 -0.12797,0.18979 -0.15823,0.27422c-0.04283,0.11943 -0.11818,0.17171 -0.15826,0.45702c-0.01267,0.09025 -0.11818,0.17171 -0.15824,0.45704c-0.01265,0.09023 0,0.18279 -0.07913,0.18279c-0.07911,0 -0.10231,0.11819 -0.15823,0.1828c-0.11191,0.12928 -0.16428,0.05645 -0.23741,0.09142c-0.10336,0.04947 -0.18141,0.02677 -0.23734,0.09139c-0.11192,0.12927 0,0.36563 0,0.54842c0,0.0914 -0.15096,0.22816 -0.47474,0.27422c-0.07855,0.01116 -0.13402,0.04194 -0.23741,0.09139c-0.07307,0.03497 -0.15822,0 -0.23737,0c-0.15823,0 -0.31648,0 -0.87035,0c-0.3165,0 -0.63301,0 -0.71211,0c-0.07912,0 -0.23839,0.01465 -0.3165,0c-0.24699,-0.0463 -0.32073,-0.04942 -0.47476,-0.09139c-0.17219,-0.04697 -0.31854,-0.06213 -0.47475,-0.09142c-0.24698,-0.0463 -0.39561,-0.0914 -0.55386,-0.0914c-0.31651,0 -0.79127,0 -1.42423,0c-0.23738,0 -0.39564,0 -0.55389,0c-0.07912,0 -0.2374,0 -0.39564,0c-0.15825,0 -0.3165,0 -0.47473,0c-0.15825,0 -0.23738,0 -0.39563,0c-0.23739,0 -0.39561,0 -0.47474,0c-0.15826,0 -0.21314,-0.04192 -0.31648,-0.0914c-0.14623,-0.06997 -0.30693,-0.04509 -0.55389,-0.09139c-0.1562,-0.02929 -0.30045,-0.02346 -0.39562,-0.09141c-0.21286,-0.15196 -0.28622,-0.09836 -0.31651,-0.18282c-0.04281,-0.11942 -0.13399,-0.13335 -0.23736,-0.18281c-0.14619,-0.06996 -0.29224,-0.13333 -0.39561,-0.18281c-0.14622,-0.06994 -0.31654,0 -0.39566,-0.0914c-0.0791,-0.09139 -0.12257,-0.17872 -0.39561,-0.2742c-0.15145,-0.05298 -0.21311,-0.04194 -0.31651,-0.09142c-0.0731,-0.03496 -0.1443,-0.13586 -0.31649,-0.1828c-0.077,-0.02101 -0.24943,-0.02145 -0.39561,-0.0914c-0.10339,-0.04946 -0.18143,-0.11817 -0.2374,-0.1828c-0.11189,-0.12926 -0.24939,0.06996 -0.39561,0c-0.10337,-0.04948 -0.17297,-0.15471 -0.31651,-0.27422c-0.09076,-0.07558 -0.1466,-0.10722 -0.23738,-0.18281c-0.1435,-0.1195 -0.23736,-0.09142 -0.31648,-0.1828c-0.07913,-0.0914 -0.07913,-0.27422 -0.15825,-0.36563c-0.07913,-0.09139 -0.11543,-0.15478 -0.15826,-0.27419c-0.03027,-0.08445 0.01817,-0.18526 0,-0.27422c-0.04065,-0.19891 -0.15825,-0.36562 -0.15825,-0.45702c0,-0.1828 -0.04586,-0.37996 -0.23737,-0.91405c-0.06771,-0.18882 -0.10231,-0.20957 -0.15825,-0.27419c-0.11189,-0.12927 -0.09284,-0.35216 -0.15826,-0.45704c-0.10345,-0.1658 -0.04276,-0.27909 -0.07912,-0.45701c-0.04065,-0.19891 -0.15825,-0.36561 -0.15825,-0.54843c0,-0.1828 0,-0.36561 0,-0.54842c0,-0.27422 0,-0.45704 0,-0.63984c0,-0.18279 0,-0.36561 0,-0.45702c0,-0.09139 0.03927,-0.26577 0.07912,-0.63983c0.01934,-0.18145 0,-0.54842 0,-0.63982c0,-0.09141 0.16785,-0.35454 0,-0.54843c-0.05595,-0.06463 -0.14863,-0.22792 -0.39564,-0.27421c-0.1562,-0.02929 -0.15823,-0.0914 -0.15823,-0.45702c0,-0.63983 -0.03635,-0.73613 0,-0.91404c0.04065,-0.19892 0.07913,-0.27422 0.07913,-0.63984c0,-0.0914 0.03906,-0.26311 0.0791,-0.54842c0.02538,-0.18043 0,-0.36563 0,-0.54842c0,-0.18282 0.03638,-0.2791 0,-0.45701c-0.04062,-0.19892 -0.15823,-0.36563 -0.15823,-0.54844c0,-0.1828 0,-0.63983 0,-0.73122c0,-0.2742 0,-0.45702 0,-0.54843c0,-0.09139 0,-0.27422 0,-0.45702c0,-0.1828 0,-0.36562 0,-0.54843c0,-0.18282 0,-0.36562 0,-0.45701c0,-0.0914 0,-0.27422 0,-0.45702c0,-0.09141 0,-0.18282 0,-0.54844c0,-0.0914 0.02316,-0.20956 0.07913,-0.2742c0.05597,-0.06464 0.16035,-0.11239 0.23738,-0.09141c0.17218,0.04697 0.21311,0.13334 0.31648,0.18281c0.0731,0.03497 0.1975,0.00843 0.23738,-0.36561c0.01934,-0.18143 0.07912,-0.82264 0.07912,-1.00545c0,-0.09141 0,-0.2742 0,-0.45702c0,-0.1828 0,-0.54842 0,-0.91405c0,-0.1828 0.0363,-0.42899 0.07912,-0.54842c0.03027,-0.08445 0,-0.36561 0,-0.45702c0,-0.09141 0,-0.36562 0,-0.54842c0,-0.0914 -0.05597,-0.20958 0,-0.27421c0.11189,-0.12928 0.23737,0 0.39561,0c0.07912,0 0.31573,0.01916 0.39563,-0.63984c0.01097,-0.09052 0.09769,-0.47094 0.15823,-0.63982c0.04285,-0.11943 0.15945,-0.16048 0.31651,-0.18282c0.32379,-0.04606 0.36286,-0.05354 0.47473,-0.18281c0.11192,-0.12928 0.07915,-0.36563 0.07915,-0.54842c0,-0.0914 0,-0.27422 0,-0.45702c0,-0.27422 -0.06058,-0.47093 0,-0.63983c0.04283,-0.11942 0.06516,-0.31866 0.23738,-0.36562c0.15401,-0.04199 0.31648,0 0.47473,0c0.23736,0 0.26467,-0.10757 0.39561,-0.54841c0.05743,-0.19333 0.1182,-0.35453 0.15825,-0.63984c0.01268,-0.09023 -0.03027,-0.28117 0,-0.36562c0.04283,-0.11942 0.07913,-0.1828 0.07913,-0.27421c0,-0.09141 0,-0.18281 0,-0.2742c0,-0.09141 -0.07135,-0.25817 0.07912,-0.36563c0.13461,-0.09611 0.31651,0 0.47473,0c0.15826,0 0.46088,-0.08245 0.55389,0.09142c0.04159,0.07774 0.07911,0.0914 0.15825,0.0914c0.07912,0 0.13399,0.13333 0.23736,0.18282c0.14622,0.06995 0.15825,-0.18282 0.15825,-0.45704l0,-0.0914l0.15826,0" id="svg_13" stroke="#000000" fill="none"/>
 
                                
                                </svg>
                            </div>
                            <div class="span6" id="derecha" style="display: none;">
                                <div class="row" style="text-align: center;">
                                    <h3 style="margin-left: -65px;" id="dienteSeleccionado"></h3>
                                    <svg style="width: 150px; height: 100px;" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
                                    <image xlink:href="<%=request.getContextPath()%>/images/diente.png" height="84" width="86" y="0" x="0"/> 

                                    <polygon class="parte" id="arriba" points="10,6,70,6,55,25,30,25" 
                                             style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" />
                                    <polygon class="parte" id="izq" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="5,13,24,32,24,57,5,80"/>

                                    <polygon class="parte" id="abajo" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="10,80,30,60,57,60,70,80"/>

                                    <polygon class="parte" id="der" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="82,2,60,35,60,50,78,85"/>

                                    <circle class="parte" id="centro" style="fill:transparent" r="11" cy="43" cx="42"></circle>

                                    </svg>
                                </div>
                                <div class="row">
                                    <div class="span6">
                                        <h3>Elija Zona</h3>
                                        <select id="zonaeditar" multiple="multiple" size="9" name="zonaeditar">
                                            <option selected="selected" value=""></option>
                                            <option value="V">V</option>
                                            <option value="M">M</option>0"></option>
                                            <option value="V">V</option>
                                            <option value="D">D</option>
                                            <option value="P">P</option>
                                            <option value="L">L</option>
                                            <option value="O">O</option>
                                            <option value="I">I</option>
                                        </select>
                                    </div>

                                    <div class="span6"> 
                                        <h3>Elija Enfermedad</h3>
                                        <select id="enfermedadeditar" multiple="multiple" size="9" name="enfermedadeditar">
                                            <option selected="selected" value=""></option>
                                            <option value="1">Cariado</option>
                                            <option value="2">Obturado almagana</option>
                                            <option value="3">Obturado resina</option>
                                            <option value="4">Exodoncia realizada</option>
                                            <option value="5">Exodoncia simple indicada</option>
                                            <option value="6">Exodoncia quirurgica ind</option>
                                            <option value="7">Sin eruocionar</option>
                                            <option value="8">Endodoncia realizada</option>
                                            <option value="9">Endo indicada</option>
                                            <option value="10">Sellante presente</option>
                                            <option value="11">Sellante indicado</option>
                                            <option value="12">Erosion o abrasion</option>
                                            <option value="13">Procedimiento realizado</option>
                                            <option value="14">Corona buen estado</option>
                                            <option value="15">Corona mal estado</option>
                                            <option value="16">Provisional buen estado</option>
                                            <option value="17">Provisional mal estado</option>
                                            <option value="18">Nucleo buen estado</option>
                                            <option value="19">Nucleo mal estado</option>
                                        </select>  
                                    </div>    
                                </div>
                                <div class="row">
                                    <div class="form-actions">
                                        <button class="btn btn-primary" type="submit">Agregar</button>
                                        <button class="btn" type="reset">Eliminar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </form>
            </div>
        </div>

        <!-----------------PESTANA 5---------------------------->
        <div class="tab-pane fade" id="diag">
            <div class="span12">
                <form class="form-horizontal" method="post" id="formDiag">
                    <fieldset>
                        <legend>Diagnosticos</legend>
                        <div class="span12">
                            <input type="text" name="tags" autocomplete="off" placeholder="Diagnostico" class="tagManager"/>
                        </div>

                        <button class="btn" style="margin-top: 18px;margin-left: 20px;" type="button" id="guardarDiag" data-original-title="Guardar diagnosticos" data-loading-text="Guardando diagnosticos..." autocomplete="off">Guardar diagnosticos</button>
                    </fieldset>        
                </form>
                <form method="post" id="formPron">
                    <fieldset>
                        <legend>Pronostico</legend>    
                        <div class="control-group">
                            <label class="control-label">Pronostico</label>
                            <div class="controls">
                                <label class="radio inline">
                                    <input type="radio" value="Bueno" name="pronostico" class="{required:true}" >
                                    Bueno
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="Regular" name="pronostico" >
                                    Regular
                                </label>
                                <label class="radio inline">
                                    <input type="radio" value="Malo" name="pronostico" >
                                    Malo
                                </label>
                            </div>
                        </div>
                        <button class="btn" style="margin-top: 18px;margin-left: 20px;" type="button" id="guardarProno" data-original-title="Guardar pronostico" data-loading-text="Guardando pronostico..." autocomplete="off">Guardar pronostico</button>
                    </fieldset>
                </form>
                <br> 
                <form method="post" id="formOtros">
                    <fieldset>
                        <div class="row-fluid">
                            <div class="span3">
                                <fieldset>
                                    <legend>Interconsulta</legend>  
                                    <c:forEach items="${interconsulta.rowsByIndex}" var="row" varStatus="sta">
                                        <label class="checkbox">
                                            <input type="checkbox" value="${row[0]}" name="interconsulta${sta.index}" > ${row[1]}
                                        </label>
                                    </c:forEach>
                                </fieldset> 
                            </div>

                            <div class="span3">
                                <fieldset>
                                    <legend>Plan de tratamiento</legend>  
                                    <c:forEach items="${planTratamiento.rowsByIndex}" var="row" varStatus="sta">
                                        <label class="checkbox">
                                            <input type="checkbox" value="${row[0]}" name="plantratamiento${sta.index}"> ${row[1]}
                                        </label>
                                    </c:forEach>

                                </fieldset> 
                            </div>
                            <div class="span3">
                                <fieldset>
                                    <legend>Remision</legend>  
                                    <c:forEach items="${remision.rowsByIndex}" var="row" varStatus="sta">
                                        <label class="checkbox">
                                            <input type="checkbox" value="${row[0]}" name="remision${sta.index}"> ${row[1]}
                                        </label>
                                    </c:forEach>
                                </fieldset> 
                            </div>

                        </div>

                        <button class="btn" style="margin-top: 18px;margin-left: 20px;" type="button" id="guardarOtros" data-original-title="Guardar cambios" data-loading-text="Guardando cambios..." autocomplete="off">Guardar cambios</button>


                    </fieldset>
                </form>
                <br> 
                <form method="post" id="formTrata">
                    <fieldset>
                        <legend>Tratamiento</legend>
                        <div class="span12">
                            <input type="text" name="tags2" autocomplete="off" placeholder="Tratamiento" class="tagManager2"/>
                        </div>
                        <label style="margin-top: 18px;margin-left: 20px;">Presupuesto</label>
                        <input style="margin-top: 18px;margin-left: 20px;" type="text" name="tagpresupuesto" id="tagpresupuesto"  value="0"/>
                        <br>
                        <button class="btn" style="margin-top: 18px;margin-left: 20px;" type="button" id="guardarTrat" data-original-title="Guardar tratamientos" data-loading-text="Guardando tratamientos..." autocomplete="off">Guardar tratamientos</button>
                    </fieldset>   
                </form>
                <br>
                <form method="post" id="formEvol">
                    <fieldset>
                        <legend>Evolucion</legend>

                        <table class="table table-striped table-bordered table-condensed" id="tablaEvol" >
                            <thead>
                                <tr>
                                    <th>Fecha</th>
                                    <th>#Recibo Pago</th>
                                    <th>Tratamiento Ejecutado</th>
                                    <th>Codigo Tratamiento</th>

                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="fechaE" id="fechaE" class="input-medium fecha" data-datepicker="datepicker"></td>
                                    <td><input type="text" name="reciboE" id="reciboE" class="input-medium"></td>
                                    <td><textarea rows="3" class="input-xlarge textareaTratamiento" name="tratamientoE" id="tratamientoE"></textarea></td>
                                    <td><input type="text" name="codigoTratE" id="codigoTratE" class="input-medium"></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarEvol">Agregar Evolucion</button>

                    </fieldset>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal hide fade" id="myModalDiente">
    <div class="modal-header">


    </div>
    <div class="modal-body">
        <div class="sample span6">
            <img id='phone' src='diente.jpeg' width='200' height='200' />
        </div>
        <div class="span6">
            <h4>Examen clinico</h4>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary" type="button">Guardar</button>
    </div>

</div>