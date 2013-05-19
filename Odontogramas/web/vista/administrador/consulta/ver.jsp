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
        
        $("#enfermedades").click(function(ev){
            var idDiente = $("#dienteSeleccionado").text().split(" ");
            
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=agregarEnfermedad",
                data: "zonas="+$("#zonaeditar").val()+"&enfermedades="+$("#enfermedadeditar").val()+"&diente="+idDiente[1],
                success: function(){
                    
                }
            })
                
        });
        
        
        $(".diente").click(function(ev){
            $('#derecha').modal();
            $("#dienteSeleccionado").text("Diente "+ $(this).attr("id"));
            if($(this).attr("id")>40 && $(this).attr("id")<49 || $(this).attr("id")>30 && $(this).attr("id")<39){
                $("#palatinaLingual").val("L");
                $("#palatinaLingual").attr("value").val("L");
            }
        });
        
        $(".parte").click(function(ev){
            //primer cuadrante
           
            var idDiente = $("#dienteSeleccionado").text().split(" ");
            if(idDiente[1]>20 && idDiente[1]<29){
                var parte = $(this).attr("id");
                if(parte=="oclusal1"){
                    $("#nada").attr("selected",false);
                    if($("#oclusal").attr("selected")){
                        $("#oclusal").attr("selected",false);    
                    }else{
                        $("#oclusal").attr("selected",true);    
                    }
                    
                }else{
                    if(parte=="vestibular1"){
                        $("#nada").attr("selected",false);
                        if($("#vestibular").attr("selected")){
                            $("#vestibular").attr("selected",false);    
                        }else{
                            $("#vestibular").attr("selected",true);
                        }
                        
                    }else{
                        if(parte=="mesial1"){
                            $("#nada").attr("selected",false);
                            if($("#mesial").attr("selected")){
                                $("#mesial").attr("selected",false);    
                            }else{
                                $("#mesial").attr("selected",true);
                            }
                            
                        }else{
                            if(parte=="distal1"){
                                $("#nada").attr("selected",false);
                                if($("#distal").attr("selected")){
                                    $("#distal").attr("selected",false);
                                }else{
                                    $("#distal").attr("selected",true);    
                                }
                                
                            }else{
                                if(parte=="palatinaLingual1"){
                                    $("#nada").attr("selected",false);
                                    if($("#palatinaLingual").attr("selected")){
                                        $("#palatinaLingual").attr("selected",false);    
                                    }else{
                                        $("#palatinaLingual").attr("selected",true);
                                    }
                                    
                                }
                            }   
                        }
                    }   
                }
            }
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
        <li class="active"><a href="#profile" data-toggle="tab">I. Antecedentes Personales</a></li>
        <li ><a href="#otro" data-toggle="tab">Examen F&iacute;sico y Estomatol&oacute;gico</a></li>
        <li ><a href="#odonto" data-toggle="tab">Odontograma</a></li>
        <li ><a href="#diag" data-toggle="tab">Diagnostico Y Tratamiento </a></li>
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
                            <label for="antOdon" class="control-label">Antecedentes odontol&oacute;gicos</label>
                            <div class="controls">
                                <textarea rows="3" id="antOdon" name="antOdon" class="input-xxlarge">${consulta.getRowsByIndex()[0][12]}</textarea>
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
                            <label for="procedencia" class="control-label">Procedencia</label>
                            <div class="controls">
                                <textarea rows="3" id="procedencia" name="procedencia" class="input-xxlarge">${consulta.getRowsByIndex()[0][13]}</textarea>
                            </div>
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
                        <legend>II. Examen F&iacute;sico y Estomatol&oacute;gico</legend>
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
                            <label for="frecuenciaRes" class="control-label">Frecuencia respiratoria</label>
                            <div class="controls">
                                <input id="frecuenciaRes" name="frecuenciaRes"  type="text" value="${examenfisicoestomatologicoList.getRowsByIndex()[0][12]}">
                            </div>
                        </div>
                        <legend>Examen Extraoral</legend>
                        <div class="control-group">
                            <label class="control-label" for="extraoral">Examen extraoral</label>
                            <div class="controls">
                                <textarea class="input-xxlarge" name="extraoral" id="extraoral" rows="3">${examenfisicoestomatologicoList.getRowsByIndex()[0][15]}</textarea>
                            </div>
                        </div>    
                        <legend>Examen Intraoral</legend>        
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
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Glosofagia"}'>
                                            <option selected="selected" value="Glosofagia">Glosofagia</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Glosofagia">Glosofagia</option>
                                        </c:otherwise>
                                    </c:choose>  
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Onicofagia"}'>
                                            <option selected="selected" value="Onicofagia">Onicofagia</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Onicofagia">Onicofagia</option>
                                        </c:otherwise>
                                    </c:choose>  
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Queilofagia"}'>
                                            <option selected="selected" value="Queilofagia">Queilofagia</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Queilofagia">Queilofagia</option>
                                        </c:otherwise>
                                    </c:choose>  
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Succion digital"}'>
                                            <option selected="selected" value="Succion digital">Succi&oacute;n digital</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Succion digital">Succi&oacute;n digital</option>
                                        </c:otherwise>
                                    </c:choose>  
                                    <c:choose>
                                        <c:when test='${examenfisicoestomatologicoList.getRowsByIndex()[0][10] == "Succion labial"}'>
                                            <option selected="selected" value="Succion labial">Succi&oacute;n labial</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Succion labial">Succi&oacute;n labial</option>
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
                        <div class="control-group">
                            <label for="frecuenciaHabito" class="control-label">Frecuencia</label>
                            <div class="controls">
                                <input id="frecuenciaHabito" name="frecuenciaHabito"  type="text" value="${examenfisicoestomatologicoList.getRowsByIndex()[0][13]}">
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="evolucionHabito" class="control-label">Tiempo de evoluci&oacute;n</label>
                            <div class="controls">
                                <input id="evolucionHabito" name="evolucionHabito"  type="text" value="${examenfisicoestomatologicoList.getRowsByIndex()[0][14]}">
                            </div>
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
                                <svg style="width: 450px; height: 500px;" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
                                <image xlink:href="<%=request.getContextPath()%>/images/adultos.gif" height="479" width="340" y="20" x="20"/>
                                <path class="diente" id="28" d="m75.02954,185.01855c0.07912,0 0.23735,0 0.39563,0c0.15825,0 0.32074,-0.04199 0.47473,0c0.17221,0.04697 0.30692,0.13652 0.55389,0.18283c0.07808,0.01462 0.31648,0 0.47473,0c0.07913,0 0.3165,0 0.39561,0c0.07915,0 0.23738,0 0.39563,0c0.0791,0 0.31651,0 0.39561,0c0.07913,0 0.2374,0 0.39565,0c0.47475,0 0.55388,0 0.63298,0c0.15823,0 0.39565,0 0.55388,0c0.15825,0 0.31651,0 0.47475,0c0.23737,0 0.39561,0 0.55388,0c0.15825,0 0.31648,0 0.55385,0c0.15826,0 0.31651,0 0.47478,0c0.07912,0 0.15822,0 0.31648,0c0.15825,0 0.29224,0.04192 0.39563,0.0914c0.07309,0.03497 0.15825,0.0914 0.15825,0.36562c0,0.0914 0.04886,0.28117 0.0791,0.36562c0.04286,0.11942 0.17197,0.07794 0.23741,0.1828c0.10345,0.16582 0.11542,0.24619 0.15823,0.36562c0.03026,0.08446 0.07912,0.09142 0.23737,0.09142c0.15826,0 0.39563,-0.09142 0.71213,-0.09142c0.07912,0 0.24338,0.03497 0.3165,0c0.10336,-0.04947 0.23735,-0.0914 0.39561,-0.0914c0.15828,0 0.44197,0.12927 0.55385,0c0.05597,-0.06462 0.15828,-0.09142 0.31653,-0.09142c0.15826,0 0.26477,0.0645 0.39565,0.27423c0.10344,0.1658 0.04633,0.32774 0.15825,0.45702c0.05592,0.06464 0.22339,0.04443 0.3956,0.0914c0.077,0.02101 0.15826,0.0914 0.3165,0.0914c0.23737,0 0.32251,0.05644 0.39563,0.0914c0.10339,0.04947 0.24338,0.14784 0.31651,0.18282c0.10336,0.04947 0.13396,0.13335 0.23735,0.1828c0.07312,0.035 0.2374,0.09142 0.31651,0.09142c0.15822,0 0.32251,0.05644 0.3956,0.0914c0.10339,0.04947 0.14009,0.09386 0.15826,0.1828c0.04066,0.19891 0.08516,0.23924 0.15825,0.27422c0.10339,0.04947 0.0791,0.18283 0.0791,0.27422c0,0.09138 0.03632,0.15479 0.07916,0.27422c0.03026,0.08444 0.07912,0.1828 0.15822,0.27422c0.07915,0.09138 0.11667,0.19646 0.15826,0.27422c0.09303,0.17386 0.30486,0.19861 0.39563,0.2742c0.14355,0.11951 0.08685,0.25816 0.23738,0.36563c0.06729,0.04803 0.18141,0.11815 0.23738,0.1828c0.05591,0.06464 0.04881,0.09836 0.0791,0.1828c0.04283,0.11943 0.04636,0.23636 0.15825,0.36563c0.05594,0.06464 0.07913,0.0914 0.15825,0.18282c0.07913,0.09138 0.07913,0.1828 0.07913,0.2742c0,0.09138 0.07912,0.1828 0.07912,0.36562c0,0.0914 0,0.2742 0,0.3656c0,0.0914 0.11819,0.17172 0.15826,0.45703c0.03802,0.27068 0.01369,0.44357 0.07912,0.54842c0.10344,0.16582 -0.03278,0.41917 0.07912,0.54843c0.05595,0.06464 0.12799,0.09836 0.15825,0.18282c0.0428,0.11942 0.19456,0.15479 0.23738,0.27422c0.06058,0.16888 0.02318,0.30098 0.07912,0.36562c0.05595,0.06464 0,0.18282 0,0.2742c0,0.0914 0,0.18282 0,0.27423c0,0.0914 0.15825,0.36559 0.2374,0.45702c0.0791,0.09138 0.09384,0.15471 0.23738,0.2742c0.09074,0.07558 0.0791,0.1828 0.0791,0.36562c0,0.0914 -0.03629,0.1548 -0.0791,0.27422c-0.0303,0.08446 0,0.1828 0,0.54842c0,0.09142 -0.07141,0.25816 0.0791,0.36562c0.06731,0.04805 0.07912,0.09142 0.07912,0.18282c0,0.0914 0,0.54843 0,0.63983c0,0.0914 0.07915,0.2742 0.15825,0.457c0.07912,0.18282 0.11543,0.24622 0.15826,0.36563c0.06056,0.16888 0,0.2742 0,0.36562c0,0.27422 0,0.36562 0,0.63983c0,0.0914 0,0.27422 0,0.36562c0,0.0914 0.02432,0.29121 -0.07915,0.45702c-0.06541,0.10487 -0.12794,0.28117 -0.15822,0.36562c-0.04285,0.11945 -0.04637,0.23636 -0.15826,0.36562c-0.05595,0.06464 -0.18141,0.02678 -0.23738,0.0914c-0.05595,0.06464 -0.01369,0.35217 -0.0791,0.45703c-0.10347,0.16582 -0.19458,0.33759 -0.2374,0.45702c-0.03026,0.08447 0.02428,0.22476 -0.07912,0.27422c-0.0731,0.03499 -0.10231,0.02678 -0.15823,0.0914c-0.05597,0.06462 -0.01369,0.35216 -0.07915,0.45703c-0.10345,0.16582 -0.07912,0.36562 -0.07912,0.54842c0,0.09143 -0.10229,0.11818 -0.15825,0.18283c-0.05595,0.06461 -0.0928,0.16934 -0.15828,0.27419c-0.10342,0.16582 -0.1814,0.30099 -0.23735,0.36563c-0.05594,0.06462 -0.07912,0.09142 -0.07912,0.27422c0,0.0914 -0.15826,0.2742 -0.15826,0.45702c0,0.0914 -0.10231,0.20958 -0.15822,0.2742c-0.11189,0.12926 -0.09056,0.2682 -0.15828,0.45703c-0.09573,0.26704 -0.10229,0.39238 -0.15826,0.45702c-0.05591,0.06462 -0.10228,0.02676 -0.15822,0.0914c-0.05595,0.06462 0.02425,0.22476 -0.07913,0.27422c-0.0731,0.03499 -0.12798,0.09834 -0.15825,0.18282c-0.04282,0.11942 -0.15825,0.2742 -0.23737,0.2742c-0.15825,0 -0.24921,0.04337 -0.31653,0.0914c-0.15048,0.10747 -0.14427,0.22725 -0.31647,0.27423c-0.077,0.021 -0.09096,0.04333 -0.15826,0.0914c-0.30101,0.21487 -0.27368,0.33759 -0.31648,0.457c-0.06056,0.16888 -0.00282,0.41171 -0.23738,0.82266c-0.0616,0.10789 -0.05487,0.22473 -0.15825,0.2742c-0.0731,0.03499 -0.09686,0.08252 -0.15823,0.27422c-0.11319,0.35345 -0.19456,0.3376 -0.23738,0.45702c-0.03029,0.08443 -0.07913,0.1828 -0.2374,0.36562c-0.15823,0.18282 -0.23737,0.18282 -0.3165,0.27422c-0.0791,0.09138 -0.16426,0.14781 -0.23737,0.1828c-0.10338,0.04947 -0.14659,0.10724 -0.23738,0.18282c-0.28706,0.23901 -0.47475,0.18279 -0.55385,0.2742c-0.07912,0.09142 -0.15826,0.18282 -0.2374,0.2742c-0.07912,0.09142 -0.12798,0.18979 -0.15823,0.27423c-0.04283,0.11943 -0.11818,0.17171 -0.15826,0.45702c-0.01266,0.09026 -0.11816,0.17171 -0.15823,0.45703c-0.01265,0.09024 0,0.1828 -0.07913,0.1828c-0.0791,0 -0.10231,0.11819 -0.15823,0.1828c-0.11191,0.12927 -0.16428,0.05646 -0.23741,0.09143c-0.10335,0.04945 -0.18141,0.02676 -0.23735,0.09138c-0.11191,0.12927 0,0.36563 0,0.54842c0,0.0914 -0.15094,0.22818 -0.47473,0.27423c-0.07855,0.01117 -0.13402,0.04195 -0.23741,0.0914c-0.07307,0.03497 -0.15822,0 -0.23738,0c-0.15823,0 -0.31647,0 -0.87035,0c-0.3165,0 -0.63301,0 -0.71211,0c-0.07912,0 -0.23839,0.01465 -0.3165,0c-0.24699,-0.04631 -0.32074,-0.04942 -0.47476,-0.0914c-0.17218,-0.04697 -0.31854,-0.06213 -0.47475,-0.09143c-0.24698,-0.0463 -0.39561,-0.0914 -0.55385,-0.0914c-0.31651,0 -0.79128,0 -1.42424,0c-0.23738,0 -0.39565,0 -0.55388,0c-0.07913,0 -0.23741,0 -0.39565,0c-0.15825,0 -0.3165,0 -0.47473,0c-0.15825,0 -0.23738,0 -0.39563,0c-0.23738,0 -0.39561,0 -0.47475,0c-0.15825,0 -0.21313,-0.04192 -0.31647,-0.0914c-0.14624,-0.06996 -0.30695,-0.04509 -0.55389,-0.09138c-0.1562,-0.02928 -0.30046,-0.02345 -0.39563,-0.0914c-0.21286,-0.15196 -0.28622,-0.09837 -0.31651,-0.18282c-0.0428,-0.11943 -0.13399,-0.13336 -0.23735,-0.18282c-0.14621,-0.06996 -0.29225,-0.13333 -0.39561,-0.18282c-0.14622,-0.06995 -0.31654,0 -0.39566,-0.0914c-0.0791,-0.09138 -0.12257,-0.17871 -0.39561,-0.2742c-0.15144,-0.05298 -0.2131,-0.04193 -0.3165,-0.09142c-0.0731,-0.03496 -0.1443,-0.13586 -0.3165,-0.1828c-0.077,-0.02101 -0.24942,-0.02145 -0.3956,-0.09142c-0.10339,-0.04945 -0.18143,-0.11816 -0.2374,-0.1828c-0.11189,-0.12926 -0.24939,0.06996 -0.39561,0c-0.10338,-0.04947 -0.17297,-0.15469 -0.31651,-0.27422c-0.09076,-0.07558 -0.14659,-0.10722 -0.23737,-0.18282c-0.14351,-0.11949 -0.23737,-0.0914 -0.3165,-0.1828c-0.07913,-0.0914 -0.07913,-0.27422 -0.15823,-0.36563c-0.07913,-0.09138 -0.11543,-0.15477 -0.15826,-0.27419c-0.03027,-0.08446 0.01817,-0.18526 0,-0.27422c-0.04065,-0.19891 -0.15825,-0.36562 -0.15825,-0.45703c0,-0.1828 -0.04585,-0.37994 -0.23737,-0.91405c-0.0677,-0.18883 -0.10231,-0.20958 -0.15825,-0.27419c-0.11189,-0.12927 -0.09283,-0.35217 -0.15826,-0.45705c-0.10345,-0.16579 -0.04276,-0.2791 -0.07912,-0.45702c-0.04065,-0.19891 -0.15825,-0.3656 -0.15825,-0.54843c0,-0.1828 0,-0.3656 0,-0.5484c0,-0.27423 0,-0.45705 0,-0.63985c0,-0.18279 0,-0.36562 0,-0.45702c0,-0.0914 0.03928,-0.26578 0.07913,-0.63983c0.01933,-0.18146 0,-0.54843 0,-0.63983c0,-0.0914 0.16785,-0.35452 0,-0.54842c-0.05595,-0.06464 -0.14864,-0.22792 -0.39565,-0.27422c-0.1562,-0.02928 -0.15823,-0.0914 -0.15823,-0.45702c0,-0.63983 -0.03636,-0.73613 0,-0.91405c0.04065,-0.19891 0.07913,-0.27422 0.07913,-0.63983c0,-0.0914 0.03906,-0.26311 0.0791,-0.54843c0.02538,-0.18042 0,-0.36562 0,-0.54842c0,-0.18282 0.03639,-0.2791 0,-0.45702c-0.04062,-0.19891 -0.15823,-0.36562 -0.15823,-0.54843c0,-0.1828 0,-0.63983 0,-0.73123c0,-0.2742 0,-0.45702 0,-0.54843c0,-0.09138 0,-0.27422 0,-0.45702c0,-0.1828 0,-0.36562 0,-0.54842c0,-0.18283 0,-0.36563 0,-0.45702c0,-0.0914 0,-0.27422 0,-0.45702c0,-0.09142 0,-0.18282 0,-0.54845c0,-0.09138 0.02316,-0.20956 0.07913,-0.2742c0.05597,-0.06464 0.16035,-0.1124 0.23738,-0.09142c0.17218,0.04697 0.2131,0.13333 0.31648,0.18282c0.0731,0.03497 0.19749,0.00842 0.23738,-0.36562c0.01935,-0.18143 0.07913,-0.82263 0.07913,-1.00545c0,-0.0914 0,-0.2742 0,-0.45702c0,-0.1828 0,-0.54843 0,-0.91406c0,-0.1828 0.03629,-0.42899 0.07912,-0.5484c0.03027,-0.08446 0,-0.36562 0,-0.45703c0,-0.0914 0,-0.3656 0,-0.54842c0,-0.0914 -0.05597,-0.20958 0,-0.27422c0.11189,-0.12927 0.23737,0 0.39561,0c0.07913,0 0.31573,0.01917 0.39563,-0.63983c0.01097,-0.09052 0.09769,-0.47093 0.15823,-0.63982c0.04285,-0.11943 0.15945,-0.16049 0.3165,-0.18282c0.32379,-0.04607 0.36287,-0.05354 0.47473,-0.18282c0.11192,-0.12929 0.07916,-0.36563 0.07916,-0.54842c0,-0.0914 0,-0.27423 0,-0.45703c0,-0.27422 -0.06058,-0.47093 0,-0.63983c0.04283,-0.11942 0.06516,-0.31865 0.23738,-0.36562c0.15401,-0.04199 0.31648,0 0.47473,0c0.23735,0 0.26466,-0.10757 0.39561,-0.54842c0.05743,-0.19333 0.11819,-0.35452 0.15825,-0.63983c0.01268,-0.09023 -0.03027,-0.28117 0,-0.36563c0.04283,-0.11942 0.07913,-0.1828 0.07913,-0.2742c0,-0.0914 0,-0.18282 0,-0.2742c0,-0.09142 -0.07135,-0.25818 0.07912,-0.36563c0.13461,-0.09612 0.31651,0 0.47473,0c0.15826,0 0.46088,-0.08246 0.55389,0.09142c0.0416,0.07774 0.07912,0.0914 0.15826,0.0914c0.07912,0 0.13397,0.13333 0.23735,0.18282c0.14622,0.06995 0.15825,-0.18282 0.15825,-0.45705l0,-0.0914l0.15826,0" id="svg_13" stroke="#000000" fill="transparent"/>
                                <path class="diente" id="27" d="m72.0,150.35648c0.5921,0 1.89474,0 2.13159,0c0.35526,0 0.71053,0 0.94736,0c0.11844,0 0.5921,0 0.71054,0c0.11841,0 0.23683,0 0.47366,0c0.35529,0 0.71054,0 0.82898,0c0.11841,0 0.24583,0.04893 0.35524,0c0.15471,-0.06923 0.29118,-0.08871 0.35527,-0.25583c0.04532,-0.11816 0.35526,-0.1279 1.77631,-0.1279c0.23685,0 0.35527,0 0.5921,0c0.11844,0 0.59213,0 0.82896,0c0.23683,0 0.5921,0 0.71051,0c0.23686,0 0.94737,0 1.0658,0c0.23683,0 0.59212,0 0.94737,0c0.23683,0 0.47368,0 0.71051,0c0.23686,0 0.59212,0 0.71054,0c0.23685,0 0.35526,0 0.47369,0c0.23683,0 0.53876,-0.05478 0.71051,0.2558c0.63399,1.14647 0.47369,1.40698 0.59212,1.40698c0.11842,0 0.2404,-0.0625 0.71053,0c0.4846,0.06445 0.98407,0.299 1.30261,0.51163c0.14249,0.09511 0.43739,0.44241 0.59212,0.51164c0.32822,0.14684 0.4827,0.07896 0.59212,0.12791c0.15471,0.06921 0.63715,0.22549 1.06577,1.02325c0.13293,0.24738 0.15842,0.42337 0.35529,0.76746c0.08804,0.15384 0.20685,0.17538 0.71053,0.5116c0.22523,0.15039 0.42836,0.26556 0.47368,0.38374c0.06407,0.1671 0.36942,0.37006 0.47369,0.51163c0.6955,0.94431 0.79253,1.17494 0.94736,1.40697c0.09793,0.14676 0.32141,0.4108 0.59212,0.76746c0.10617,0.13986 0.28215,0.26553 0.23683,0.38373c-0.06409,0.1671 -0.11842,0.3837 -0.11842,0.76743c0,0.89536 0,1.02325 0,1.53488c0,0.38373 0,1.27908 0,1.40698c0,0.25583 0,0.76744 0,1.15118c0,1.15115 0,1.27905 0,1.40697c0,0.12791 0,0.38371 0,1.02325c0,0.12791 -0.18126,0.29475 0,0.76744c0.06409,0.16711 0.23683,0.51163 0.23683,0.63953c0,0.38373 0,1.40698 0,1.5349c0,0.1279 -0.01895,0.25746 0,0.38371c0.06,0.39926 0.08186,0.52081 0.23685,1.15118c0.09613,0.39091 0.23685,0.76743 0.23685,1.02325c0,0.38371 0,0.51161 0,0.76743c0,0.89536 0,1.02325 0,1.40698c0,0.12791 -0.09946,0.76909 -0.11844,0.89536c-0.05997,0.39925 -0.40958,0.444 -0.59209,1.27907c-0.02722,0.12448 -0.03468,0.42119 -0.11841,0.51164c-0.08376,0.09042 -0.09891,0.25667 -0.11842,0.51161c-0.05942,0.77539 -0.34552,0.68903 -0.47369,1.02327c-0.04532,0.11816 -0.23685,0.2558 -0.35526,0.3837c-0.11844,0.12793 -0.0278,0.27531 -0.11844,0.51164c-0.06409,0.16711 -0.23772,0.11227 -0.35526,0.12791c-0.48459,0.06442 -0.68967,0.31801 -0.94739,0.38373c-0.23048,0.05876 -0.23999,0.0985 -0.35526,0.1279c-0.25771,0.06569 -0.40959,0.21661 -0.47366,0.38371c-0.04532,0.11816 -0.08202,0.2796 -0.23685,0.51164c-0.09793,0.14673 -0.29301,0.147 -0.35527,0.25581c-0.13921,0.24329 -0.47368,0.2558 -0.5921,0.2558c-0.11842,0 -0.27153,-0.09044 -0.35527,0c-0.08374,0.09045 -0.11841,0.12791 -0.35526,0.12791c-0.11842,0 -0.23685,0 -0.47369,0c-0.5921,0 -0.82893,0 -0.94736,0c-0.11842,0 -0.24002,-0.02939 -0.35526,0c-0.25772,0.0657 -0.23685,0.25581 -0.59212,0.25581c-0.11842,0 -0.36159,-0.05876 -0.5921,0c-0.25771,0.0657 -0.35527,0.25583 -0.47368,0.25583c-0.23685,0 -0.82895,0 -0.94739,0c-0.11841,0 -0.3629,0.10242 -0.94736,0c-0.36963,-0.0648 -0.47366,-0.12791 -0.71053,-0.12791c-0.23683,0 -0.71205,-0.23534 -0.82895,-0.25583c-0.36964,-0.06479 -0.47368,-0.1279 -0.59212,-0.1279c-0.11841,0 -0.9491,0.03783 -1.30261,0c-0.60091,-0.06427 -0.71054,-0.12791 -0.82895,-0.12791c-0.11842,0 -1.42105,0 -1.77632,0c-0.35526,0 -0.47685,0.02939 -0.59212,0c-0.25771,-0.0657 -0.82893,-0.3837 -1.06577,-0.3837c-0.11844,0 -0.40407,0.004 -0.82895,-0.25583c-0.14574,-0.08913 -0.23685,-0.12791 -0.47369,-0.12791c-0.23685,0 -0.35585,0.0255 -0.82895,0c-1.18863,-0.06403 -1.53947,-0.1279 -1.77631,-0.25581c-0.23685,-0.1279 -0.35834,-0.08693 -0.5921,-0.1279c-0.36966,-0.06477 -0.53873,-0.37799 -0.94737,-0.51164c-0.2267,-0.07413 -0.23775,-0.11226 -0.35527,-0.1279c-0.4846,-0.06444 -0.43738,-0.31448 -0.5921,-0.38371c-0.21881,-0.0979 -0.40959,-0.0887 -0.47369,-0.25581c-0.09064,-0.23636 0.06152,-1.66774 0.11844,-2.04651c0.11996,-0.79852 0.47977,-0.93358 0.35526,-1.15118c-0.13922,-0.24329 -0.40959,-0.21658 -0.47369,-0.38371c-0.04532,-0.11816 0,-0.38373 0,-1.15117c0,-0.1279 0,-0.38373 -0.11841,-0.63954c-0.23685,-0.51161 -0.31897,-0.82611 -0.47369,-0.89534c-0.10941,-0.04895 -0.23685,0 -0.35526,-0.12791c-0.11844,-0.1279 -0.23685,-0.1279 -0.23685,-0.51161c0,-0.38373 0.11841,-1.02325 0.11841,-1.2791c0,-0.12788 0.0632,-0.39607 0.23685,-1.15115c0.09027,-0.39253 0.29529,-1.00772 0.35527,-1.40697c0.01897,-0.12627 -0.06462,-0.25963 0,-0.89536c0.11913,-1.17221 0.23683,-1.40698 0.23683,-1.5349c0,-0.2558 0,-0.51161 0,-1.66277c0,-0.51166 0,-1.02325 0,-1.66281c0,-0.76744 0,-1.02325 0,-1.27907c0,-0.12791 0.13596,-0.28503 0,-0.63954c-0.06407,-0.16711 -0.23683,-0.51163 -0.23683,-1.27905c0,-0.25583 -0.10866,-0.56113 -0.23683,-0.89536c-0.09064,-0.23636 -0.1405,-0.51239 -0.11844,-0.89536c0.05933,-1.02922 0.06152,-1.41194 0.11844,-1.79071c0.11996,-0.79851 0.25139,-1.01321 0.47366,-1.40695c0.63474,-1.12439 0.58173,-1.41092 0.71054,-1.79074c0.21933,-0.64676 0.37729,-0.85599 0.5921,-1.02325c0.13586,-0.10574 0.23685,-0.1279 0.47368,-0.1279c0.11842,0 0.24586,0.04895 0.35527,0c0.15472,-0.06921 0.23683,-0.2558 0.47369,-0.2558c0.23683,0 0.47366,0 0.5921,0l0.11841,-0.12793" id="svg_15" stroke="#000000" fill="transparent"/>

                                </svg>
                            </div>
                            <div class="span6">   
                                <svg style="width: 450px; height: 500px;" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
                                <image xlink:href="<%=request.getContextPath()%>/images/ninos.gif" height="479" width="340" y="20" x="20"/>
                                </svg>
                            </div>
                            <div class="modal hide fade" id="derecha">
                                <div class="modal-header">
                                    <div class="row" style="text-align: center;">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h3 id="dienteSeleccionado"></h3>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <div style="text-align: center;margin-left: 25px;" >
                                        <svg style="width: 150px; height: 100px;" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.w3.org/2000/svg">
                                        <image xlink:href="<%=request.getContextPath()%>/images/diente.png" height="84" width="86" y="0" x="0"/> 
                                        <polygon class="parte" id="vestibular1" points="10,6,70,6,55,25,30,25" 
                                                 style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" />
                                        <polygon class="parte" id="distal1" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="5,13,24,32,24,57,5,80"/>
                                        <polygon class="parte" id="palatinaLingual1" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="10,80,30,60,57,60,70,80"/>
                                        <polygon class="parte" id="mesial1" style="stroke:none; stroke-width:1; stroke-opacity:1; fill:transparent; fill-opacity:1" points="82,2,60,35,60,50,78,85"/>
                                        <circle class="parte" id="oclusal1" style="fill:transparent" r="11" cy="43" cx="42"></circle>
                                        </svg>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <div class="row">
                                        <div class="span6">
                                            <h3>Elija Zona</h3>
                                            <select id="zonaeditar" multiple="multiple" size="9" name="zonaeditar">
                                                <option id="nada" selected="selected" value=""></option>
                                                <option id="mesial" value="M">M</option>
                                                <option id="vestibular" value="V">V</option>
                                                <option id="distal" value="D">D</option>
                                                <option id="palatinaLingual" value="P">P</option>
                                                <option id="oclusal" value="O">O</option>
                                            </select>
                                        </div>

                                        <div class="span6"> 
                                            <h3>Elija Enfermedad</h3>
                                            <select id="enfermedadeditar" multiple="multiple" size="9" name="enfermedadeditar">
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
                                            <button class="btn btn-primary" type="button" id="enfermedades">Guardar Cambios</button>
                                        </div>
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


