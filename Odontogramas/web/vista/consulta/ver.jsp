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
                                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                     width="256px" height="480px" viewBox="0 0 256 480" enable-background="new 0 0 256 480" xml:space="preserve">
                                <image xlink:href="<%=request.getContextPath()%>/images/adultos.gif" height="480" width="256"/>
                                <path class="diente" id="1" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M123,31
                                      c-2,0-4,0-6,0c-1.553-7.31-7.598-10.037-8-19c4.839-2.547,9.087-3.995,17-4c0.875,2.316,1.018,4.407,1,8
                                      c-2.207,2.51-0.702,7.471-2,11c-0.333,0-0.667,0-1,0C123.667,28.333,123.333,29.667,123,31z"/>
                                <path class="diente" id="2" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M132,8
                                      c6.937-0.156,11.367,1.057,16,3c0.333,1,0.667,2,1,3c-0.333,0-0.667,0-1,0c0,1.333,0,2.667,0,4c-0.333,0-0.667,0-1,0
                                      c-0.333,1-0.667,2-1,3c-0.667,0.333-1.333,0.667-2,1c0,1.333,0,2.667,0,4c-0.667,0.333-1.333,0.667-2,1c-2.226,2.371-2.1,2.937-7,3
                                      c-1.412-2.663-2.03-4.22-2-9c-0.333,0-0.667,0-1,0c-0.333-4-0.667-8-1-12c0.333,0,0.667,0,1,0C132,8.667,132,8.333,132,8z"/>
                                <path class="diente" id="3" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M101,16
                                      c1.333,0,2.667,0,4,0c0.333,1,0.667,2,1,3c1.999,1.983,3.93,9.699,4,14c-3.122,1.816-3.387,2.982-9,3c-3.083-5.192-8.571-5.908-9-14
                                      c1.333-1,2.667-2,4-3c0-0.333,0-0.667,0-1C98.228,16.694,98.791,18.546,101,16z"/>
                                <path class="diente" id="4" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M152,16
                                      c2.666,0.333,5.334,0.667,8,1c2.494,3.68,5.646,2.669,6,9c-1,0.667-2,1.333-3,2c0,0.667,0,1.333,0,2c-2.333,1.667-4.667,3.333-7,5
                                      c0,0.333,0,0.667,0,1c-1.333,0-2.667,0-4,0c-0.736-1.408-1.797-3.023-3-4c0-3,0-6,0-9C149.727,20.781,151.364,18.781,152,16z"/>
                                <path class="diente" id="5" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M81,46
                                      c-0.587-2.239-0.836-2.506-2-4c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2c-0.667-0.333-1.333-0.667-2-1c-0.333-3-0.667-6-1-9
                                      c1-0.333,2-0.667,3-1c2.05-1.885,9.224-1.1,13-1c0.667,1,1.333,2,2,3c0.333,0,0.667,0,1,0c2.035,3.18,2.019,8.737,2,14
                                      c-4.073,2.366-3.755,3.073-11,3C83.744,46.091,83.986,46.341,81,46z"/>
                                <path class="diente" id="6" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M168,28
                                      c4,0,8,0,12,0c0,0.333,0,0.667,0,1c0.333,0,0.667,0,1,0c0.333,3.333,0.667,6.667,1,10c-1.653,1.336-2.504,3.504-4,5
                                      c-1.497,1.497-3.658,2.35-5,4c-2.666,0-5.334,0-8,0c-1.584-2.731-2.742-2.446-3-7c0.333,0,0.667,0,1,0c0-2.667,0-5.333,0-8
                                      c0.333,0,0.667,0,1,0C165.333,31.333,166.667,29.667,168,28z"/>
                                <path class="diente" id="7" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M72,44
                                      c1.333,0,2.667,0,4,0c1.838,2.573,5.846,3.885,7,7c1.969,5.316-2.922,17.98-5,19c-2,0-4,0-6,0c-4.333-2.667-8.667-5.333-13-8
                                      c0-2,0-4,0-6c1-0.667,2-1.333,3-2c0-0.667,0-1.333,0-2c1.667-1.333,3.333-2.667,5-4c0.333-0.667,0.667-1.333,1-2
                                      C69.669,44.844,70.285,46.006,72,44z"/>
                                <path class="diente" id="8" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M182,44
                                      c1.666,0,3.334,0,5,0c4.362,6.566,11.742,6.381,12,18c-5.946,3.375-9.538,7.843-19,8c-2.508-5.632-4.913-9.506-5-18
                                      c0.333,0,0.667,0,1,0c0-1,0-2,0-3C177.229,47.034,180.542,46.253,182,44z"/>
                                <path class="diente" id="9" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M55,66
                                      c3,0.667,6,1.333,9,2c1.667,2,3.333,4,5,6c0.333,0,0.667,0,1,0c1.156,1.667-0.015,2.291,2,4c0.429,10.435-0.511,18.225-11,18
                                      c0-0.333,0-0.667,0-1c-1.667-0.333-3.333-0.667-5-1c0-0.333,0-0.667,0-1c-0.667,0-1.333,0-2,0c-0.667-1-1.333-2-2-3
                                      c-0.667,0-1.333,0-2,0c-0.333-0.667-0.667-1.333-1-2c-3.629-3.553-3.116-2.812-3-10c0.333,0,0.667,0,1,0c0.333-2,0.667-4,1-6
                                      C50.333,70,52.667,68,55,66z"/>
                                <path class="diente" id="10" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M211,88
                                      c-2.238,0.578-2.514,0.835-4,2c0,0.333,0,0.667,0,1c-0.667,0-1.333,0-2,0c-0.333,0.667-0.667,1.333-1,2c-0.667,0-1.333,0-2,0
                                      c-3.292,1.694-5.843,2.817-11,3c-1.965-3.534-3.851-4.204-4-10c-0.333,0-0.667,0-1,0c0-2.667,0-5.333,0-8c0.333,0,0.667,0,1,0
                                      c0.91-4.117,9.503-14.321,16-12c0,0.333,0,0.667,0,1c0.667,0,1.333,0,2,0c0.667,1,1.333,2,2,3c0.333,0,0.667,0,1,0c0,1,0,2,0,3
                                      c1,0.667,2,1.333,3,2c0.333,3.667,0.667,7.333,1,11C210.861,87.139,211.602,86.003,211,88z"/>
                                <path class="diente" id="11" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M48,130
                                      c0-0.667,0-1.333,0-2c-3.538-0.286-4.884-1.349-8-2c-0.528-0.918-3-3-3-3c0-5.666,0-11.334,0-17c0.333,0,0.667,0,1,0
                                      c0-1.333,0-2.667,0-4c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c1.088-2.019,3.135-3.669,5-5c0-0.333,0-0.667,0-1c3,0,6,0,9,0
                                      c3.272,3.681,8.382,4.477,11,9c4.868,4.669,0.086,16.764-1,22c-1.649,0.988-4.335,4.682-5,5C54.667,130,51.333,130,48,130z"/>
                                <path class="diente" id="12" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M205,94
                                      c3,0,6,0,9,0c1.558,2.678,4.811,5.019,6,8c2.127,5.329,1.013,14.171,1,21c-1,0.667-2,1.333-3,2c0,0.333,0,0.667,0,1
                                      c-2.922,1.916-13.223,3.867-18,4c-1-1.333-2-2.667-3-4c-0.333,0-0.667,0-1,0c-0.333-2.333-0.667-4.667-1-7
                                      c-0.667-0.333-1.333-0.667-2-1c-0.333-4-0.667-8-1-12c0.333,0,0.667,0,1,0c0-1,0-2,0-3c0.333,0,0.667,0,1,0c1.666-2,3.334-4,5-6
                                      c0.667,0,1.333,0,2,0c0-0.333,0-0.667,0-1C203.005,94.855,203.43,95.81,205,94z"/>
                                <path class="diente" id="13" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M29,156
                                      c-0.333-2.667-0.667-5.333-1-8c0.333,0,0.667,0,1,0c0.333-4.333,0.667-8.667,1-13c5.729-3.439,2.617-5.084,13-5c0,0.333,0,0.667,0,1
                                      c2,0.333,4,0.667,6,1c0,0.333,0,0.667,0,1c1.333,0.333,2.667,0.667,4,1c0,0.333,0,0.667,0,1c1.667,1.333,3.333,2.667,5,4
                                      c0,2,0,4,0,6c2.452,2.627,0.274,9.513,0,13c-4.945,2.971-3.138,5.032-12,5c-2.157-1.875-5.807,0.217-9-1c0-0.333,0-0.667,0-1
                                      c-0.667,0-1.333,0-2,0c0-0.333,0-0.667,0-1C32.905,158.35,31.989,156.811,29,156z"/>
                                <path class="diente" id="14" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M215,130
                                      c3,0,6,0,9,0c0.781,1.433,2.771,4.012,4,5c0.262,4.533,2.76,11.489,1,17c-0.333,0-0.667,0-1,0c-0.333,1.667-0.667,3.333-1,5
                                      c-1.333,1-2.667,2-4,3c0,0.333,0,0.667,0,1c-3.488,2.225-12.241,2.021-18,2c-2.11-3.522-4.662-3.33-5-9c-0.333,0-0.667,0-1,0
                                      c0.333-4.666,0.667-9.334,1-14c0.333,0,0.667,0,1,0c1.054-3.91,2.848-4.206,6-6c0-0.333,0-0.667,0-1c0.667,0,1.333,0,2,0
                                      c0-0.333,0-0.667,0-1c2-0.333,4-0.667,6-1C215,130.667,215,130.333,215,130z"/>
                                <path class="diente" id="15" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M54,192
                                      c-1,0.333-2,0.667-3,1c0,0.333,0,0.667,0,1c-1,0-2,0-3,0c-0.333,0.667-0.667,1.333-1,2c-3.374,1.427-12.843-0.897-14-2
                                      c-4.074-0.94-4.166-2.933-4-8c-1.046-1.069-1.956-7.444-1-10c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0
                                      c0-1,0-2,0-3c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0
                                      c1.334-1.492,0.491-1.39,3-2c2.414-2.242,8.219-0.217,12,0c2.099,3.092,1.43,0.431,4,2c1.667,2,3.333,4,5,6
                                      c0.122,3.417,1.456,11.935,0,15c-0.333,0-0.667,0-1,0C54.908,189.646,54.635,189.68,54,192z"/>
                                <path class="diente" id="16" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M204,192
                                      c-0.631-2.264-0.855-2.442-2-4c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2c-0.333,0-0.667,0-1,0c-0.421-1.681,0.954-1.777,1-2
                                      c0.872-4.218,0.368-9.609,1-13c2.666-2,5.334-4,8-6c5.493-0.308,8.712-0.976,14,0c1.666,2.333,3.334,4.667,5,7c0,1,0,2,0,3
                                      c0.333,0,0.667,0,1,0c-0.333,5.666-0.667,11.334-1,17c-1.801,0.944-1.574,1.385-4,2c-1.28,1.317-9.364,3.406-13,2
                                      c0-0.333,0-0.667,0-1c-0.667,0-1.333,0-2,0c0-0.333,0-0.667,0-1C207.956,192.485,207.598,192.333,204,192z"/>
                                <path class="diente" id="17" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M29,293
                                      c0.667,0,1.333,0,2,0c0.333-0.667,0.667-1.333,1-2c3.667,0,7.333,0,11,0c2.436,3.876,7.411,6.463,9,11
                                      c2.569,7.336-4.246,12.681-8,14c-3.179,1.117-6.893-0.577-9-1c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0
                                      C28.932,307.328,28.981,300.791,29,293z"/>
                                <path class="diente" id="18" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M214,291
                                      c4,0,8,0,12,0c2.329,4.426,2.087,7.073,2,14c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-2.847,5.817-5.08,8.125-14,8c0-0.333,0-0.667,0-1
                                      c-1,0-2,0-3,0c0-0.333,0-0.667,0-1c-2.074-1.632-3.199-1.929-4-5c-0.333,0-0.667,0-1,0c0-2.333,0-4.667,0-7
                                      c2.001-1.721,0.843-2.322,2-4c0.667-0.333,1.333-0.667,2-1C210.666,295,212.334,293,214,291z"/>
                                <path class="diente" id="19" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M42,317
                                      c3.826-0.038,6.271,0.478,9,1c0.655,1.181,1.622,1.426,2,2c0,0.667,0,1.333,0,2c0.667,0.333,1.333,0.667,2,1
                                      c2.423,4.643,1.968,14.74,1,20c-6.777,4.04-3.736,7.058-16,7c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2
                                      c-0.333,0-0.667,0-1,0c0-1.333,0-2.667,0-4c-2.424-7.201-2.98-13.708,0-21c1.007-0.493,1.834-1.915,2-2c1.333,0,2.667,0,4,0
                                      C42,317.667,42,317.333,42,317z"/>
                                <path class="diente" id="20" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M207,317
                                      c6.669-0.242,11.603-0.045,14,4c5.159,4.973,0.149,20.699-1,26c-4.072,2.366-3.755,3.072-11,3c-2.073-3.201-4.485-2.281-7-3
                                      c-0.333-1-0.667-2-1-3c-0.333,0-0.667,0-1,0c0-1,0-2,0-3c-0.333,0-0.667,0-1,0c1-5.999,2-12.001,3-18c1-0.667,2-1.333,3-2
                                      c0-0.667,0-1.333,0-2C205.42,318.38,206.324,318.206,207,317z"/>
                                <path class="diente" id="21" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M65,356
                                      c1.212,5.808,6.633,18.622,0,23c0,0.333,0,0.667,0,1c-1.333,0-2.667,0-4,0c-0.333,0.667-0.667,1.333-1,2
                                      c-2.279,1.803-4.781,1.989-9,2c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c-0.333-1.333-0.667-2.667-1-4
                                      c-0.667-0.333-1.333-0.667-2-1c0-1.333,0-2.667,0-4c-2.07-5.98-3.186-10.225-2-17c4.736-2.119,8.781-3.902,16-4
                                      c0.702,1.412,1.439,1.227,2,2c0,0.667,0,1.333,0,2C61.954,356.094,63.039,355.772,65,356z"/>
                                <path class="diente" id="22" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M197,351
                                      c7.543-0.311,15.506,0.53,17,6c0.333,0,0.667,0,1,0c-0.333,4-0.667,8-1,12c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-0.333,0-0.667,0-1,0
                                      c0,1,0,2,0,3c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-0.667,0.333-1.333,0.667-2,1c0,0.667,0,1.333,0,2c-1,0.667-2,1.333-3,2
                                      c0,0.333,0,0.667,0,1c-2,0-4,0-6,0c-2.581-3.831-7.61-3.807-9-9c-0.333,0-0.667,0-1,0c0.667-5.333,1.333-10.667,2-16
                                      c0.667-0.333,1.333-0.667,2-1c0.333-1.666,0.667-3.334,1-5c0.667,0,1.333,0,2,0C197,352.333,197,351.667,197,351z"/>
                                <path class="diente" id="23" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M61,385
                                      c2,0,4,0,6,0c0.61,1.152,1.706,1.521,2,2c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0.333,2,0.667,4,1,6c0.333,0,0.667,0,1,0
                                      c0,1.333,0,2.667,0,4c0.333,0,0.667,0,1,0c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0,2,0,4,0,6c-5.47,4.732-4.066,7.863-14,6
                                      c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c-1.797-2.803-5.433-16.242-3-20C56.333,388.334,58.667,386.666,61,385z"/>
                                <path class="diente" id="24" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M190,385
                                      c2,0,4,0,6,0c0,0.333,0,0.667,0,1c0.667,0,1.333,0,2,0c1.666,2,3.334,4,5,6c0.333,0,0.667,0,1,0c0,2.666,0,5.334,0,8
                                      c-0.333,0-0.667,0-1,0c-0.333,2-0.667,4-1,6c-3.206,7.058-6.998,9.379-15,6c-1.936-4.629-3.002-5.896-3-13c0.333,0,0.667,0,1,0
                                      c0.333-2.333,0.667-4.667,1-7c0.333,0,0.667,0,1,0C188.246,389.43,188.928,387.353,190,385z"/>
                                <path class="diente" id="25" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M77,409
                                      c1,0,2,0,3,0c0.701,1.16,2.855,2.737,3,3c0.333,2,0.667,4,1,6c0.333,0,0.667,0,1,0c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0
                                      c1.698,4.665,0.11,14.455-3,16c-2,0-4,0-6,0c-2.61-4.188-15.267-11.839-10-20c0.333,0,0.667,0,1,0
                                      C70.631,412.734,74.458,411.985,77,409z"/>
                                <path class="diente" id="26" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M177,409
                                      c1,0,2,0,3,0c0,0.333,0,0.667,0,1c5.15,1.128,10.986,6.378,11,13c-1.997,1.723-0.844,2.323-2,4c-3.666,3.333-7.334,6.667-11,10
                                      c-5.426-2.079-7.824-4.74-8-12c1.767-2.017,0.83-5.403,2-8c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.667-0.333,1.333-0.667,2-1
                                      c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0C176.333,411,176.667,410,177,409z"/>
                                <path class="diente" id="27" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M86,434
                                      c5.658-1.31,5.227-2.376,11,0c1.335,3.57,1.047,9.913,1,15c-1.139,1.14-0.398,0.004-1,2c-2.437,0.918-6.193,1.037-10,1
                                      c-0.333-1-0.667-2-1-3c-1.983-1.896-0.024-0.522-1-3C82.908,440.687,85.323,439.013,86,434z"/>
                                <path class="diente" id="28" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M171,434
                                      c0.333,1.333,0.667,2.667,1,4c0.333,0,0.667,0,1,0c1.705,4.959-1.318,9.695-2,13c-2.437,0.918-6.193,1.037-10,1
                                      c-0.333-1-0.667-2-1-3c-2.089-2.285-1.101-10.884-1-15c1.135-0.844,0.146,0.127,1-1c2.333-0.333,4.667-0.667,7-1
                                      C168.165,433.361,168.824,433.528,171,434z"/>
                                <path class="diente" id="29" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M109,464
                                      c-1.333,0-2.667,0-4,0c-2.82-4.167-6.592-2.795-7-10c2.364-1.982,3.36-5.292,6-7c0-0.333,0-0.667,0-1c1.667-0.333,3.333-0.667,5-1
                                      c0,0.333,0,0.667,0,1C113.663,449.991,109.424,458.705,109,464z"/>
                                <path class="diente" id="30" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M148,464
                                      c0-1.333,0-2.667,0-4c-0.667,0-1.333,0-2,0c0-4.333,0-8.667,0-13c1.867-0.706,3.91-0.993,7-1c2.351,4.258,5.644,5.552,6,12
                                      C155.042,460.338,154.241,463.624,148,464z"/>
                                <path class="diente" id="31" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M126,470
                                      c-3.667,0-7.333,0-11,0c-0.333-1-0.667-2-1-3c-1.807-1.927-0.969-5.779,0-8c0.333,0,0.667,0,1,0c0.333-2,0.667-4,1-6
                                      c2.078-1.094,1.771-1.61,5-2c0.609,1.128,1.713,1.533,2,2c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0,1,0,2,0,3c0.333,0,0.667,0,1,0
                                      c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0C126,463.333,126,466.667,126,470z"/>
                                <path class="diente" id="32" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#231F20" stroke-width="0.5" stroke-miterlimit="10" d="M134,452
                                      c1.666-0.333,3.334-0.667,5-1c0.844,1.135-0.127,0.146,1,1c0.413,5.313,2.936,9.347,4,14c-1,0.667-2,1.333-3,2
                                      c-1.741,1.803-4.395,1.995-8,2c-0.706-1.867-0.993-3.91-1-7c0.333,0,0.667,0,1,0c0-3,0-6,0-9C133,454,133.691,453.834,134,452z"/>
                                </svg>    
                            </div>
                            <div class="span6">   
                                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                     width="302px" height="480px" viewBox="0 0 302 480" enable-background="new 0 0 302 480" xml:space="preserve">
                                <image xlink:href="<%=request.getContextPath()%>/images/ninos.gif" height="480" width="302"/>
                                <g>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M121.938,15.801c6.974-0.217,20.043,0.929,23.043,4.008c1.143,1.141,0.4,0.004,1.002,2.003c1.266,1.323,1.922,9.107,1.002,12.023
                                      c-0.334,0-0.667,0-1.002,0c0,1.336,0,2.672,0,4.008c-0.333,0-0.667,0-1.002,0c-0.333,2.003-0.667,4.007-1.001,6.012
                                      c-0.333,0-0.668,0-1.002,0c-1.669,2.003-3.34,4.008-5.009,6.011c-2.338,0-4.677,0-7.014,0c-1.781-1.978-2.141-0.829-4.007-2.003
                                      c-0.333-0.668-0.667-1.336-1.002-2.004c-1.001,0-2.004,0-3.005,0c-0.669-1.001-1.336-2.003-2.004-3.005c-0.668,0-1.335,0-2.004,0
                                      c-1.336-1.67-2.672-3.34-4.007-5.01c-0.668,0-1.336,0-2.004,0c0-0.334,0-0.668,0-1.002c-1.001-0.667-2.003-1.336-3.005-2.003
                                      c0-0.668,0-1.336,0-2.003c-0.668-0.334-1.336-0.668-2.004-1.003c0-2.671,0-5.343,0-8.015c1.669-1.336,3.339-2.672,5.009-4.007
                                      c0-0.334,0-0.668,0-1.002c1.67,0,3.339,0,5.01,0c0.334-0.668,0.667-1.336,1.001-2.004c1.002,0,2.004,0,3.006,0
                                      C121.938,16.47,121.938,16.135,121.938,15.801z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M183.056,22.814c3.514,0.53,5.077,0.625,6.013,4.008c0.333,0,0.668,0,1.001,0c0,1.67,0,3.34,0,5.009
                                      c-2.671,2.338-5.344,4.676-8.016,7.014c-0.334,0.668-0.668,1.336-1.003,2.003c-0.668,0-1.335,0-2.004,0
                                      c-0.334,0.669-0.667,1.336-1,2.005c-0.668,0-1.337,0-2.005,0c-0.667,1.002-1.336,2.004-2.003,3.005c-0.667,0-1.337,0-2.004,0
                                      c-0.334,0.668-0.668,1.336-1.004,2.004c-1,0-2.003,0-3.004,0c-0.336,0.667-0.668,1.336-1.003,2.003c-2.338,0-4.676,0-7.013,0
                                      c-1.67-2.003-3.342-4.008-5.012-6.011c-0.333,0-0.666,0-1,0c0-1.002,0-2.005,0-3.007c-0.334,0-0.67,0-1.003,0
                                      c0-0.667,0-1.335,0-2.003c-0.334,0-0.669,0-1.001,0c0-1.001,0-2.004,0-3.006c-0.335,0-0.669,0-1.002,0c0-5.009,0-10.02,0-15.029
                                      c2.943-1.711,2.868-2.896,8.015-3.005c4.406-4.616,20.49-0.847,25.049,1.002C183.479,20.337,183.295,20.45,183.056,22.814z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M85.868,33.836c6.159-0.203,18.275,0.454,20.04,4.008c0,5.009,0,10.021,0,15.029c-6.199,3.72-3.941,7.083-15.03,7.013
                                      c0-0.334,0-0.667,0-1.002c-1.669,0-3.339,0-5.01,0c-1.634-2.612-4.219-3.518-6.012-6.011c-0.333,0-0.667,0-1.001,0
                                      c0-3.34,0-6.68,0-10.019c0.334,0,0.668,0,1.001,0c0-1.003,0-2.005,0-3.007c0.334,0,0.669,0,1.002,0
                                      C82.528,37.844,84.198,35.839,85.868,33.836z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M214.115,40.849c0,1.002,0,2.005,0,3.007c0.335,0,0.668,0,1.002,0c0,0.333,0,0.667,0,1.002c1.336,0,2.672,0,4.008,0
                                      c0,0.333,0,0.667,0,1.001c0.334,0,0.668,0,1.002,0c-0.334,2.004-0.668,4.008-1.002,6.011c-2.004,1.67-4.008,3.34-6.012,5.01
                                      c-0.333,0.668-0.668,1.336-1.003,2.004c-1,0-2.003,0-3.004,0c-0.335,0.668-0.669,1.336-1.003,2.004c-2.338,0-4.675,0-7.014,0
                                      c-2.339-2.004-4.676-4.008-7.014-6.011c0-0.668,0-1.336,0-2.004c-0.667-0.334-1.336-0.668-2.004-1.002c0-4.675,0-9.352,0-14.027
                                      c1.175-0.651,1.441-1.636,2.004-2.004c0.667,0,1.336,0,2.004,0c0.334-0.667,0.668-1.335,1.003-2.003c4.007,0,8.016,0,12.023,0
                                      c2.711,2.964,5.482,1.691,8.015,6.011c0.334,0,0.668,0,1.002,0c0,0.334,0,0.668,0,1.001
                                      C216.787,40.849,215.451,40.849,214.115,40.849z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M49.797,85.937c0-5.009,0-10.02,0-15.029c6.481-3.938,5.067-10.942,16.032-11.021c2.434-3.439,2.985-1.265,6.012,0
                                      c1.002,0,2.004,0,3.005,0c4.614,2.709,5.36,13.089,5.009,21.041c-2.442,1.428-4.122,4.045-7.013,5.01
                                      c-6.346,0.334-12.692,0.668-19.037,1.002c-0.335-0.668-0.669-1.335-1.002-2.004C51.803,85.269,50.8,85.603,49.797,85.937z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M244.174,81.929c0.334,1.336,0.668,2.672,1.001,4.008c-5.244,1.077-18.387,2.702-22.042-1.002c-1.76-1.387,0.372-0.234-1.003-2.004
                                      c-1.335-1.002-2.671-2.004-4.007-3.006c-1.608-2.546-1.069-8.016-1.002-12.023c3.477-2.348,3.334-6.738,8.017-8.016
                                      c0-0.334,0-0.667,0-1.002c1.059-0.651,4.755-0.335,6.012-1.001c0,0.333,0,0.667,0,1.001c1.143,0.431,2.781,0.491,4.008,1.002
                                      c0,0.334,0,0.668,0,1.002c1.002,0,2.002,0,3.005,0c0,0.334,0,0.669,0,1.002c2.672,2.338,5.344,4.676,8.017,7.013
                                      c0,0.668,0,1.336,0,2.004c0.667,0.334,1.334,0.668,2.003,1.002c0,3.673,0,7.349,0,11.021c-0.336,0-0.669,0-1.003,0
                                      c0-0.333,0-0.667,0-1.002C246.179,81.929,245.175,81.929,244.174,81.929z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M63.826,129.02c-7.681,0-15.364,0-23.044,0c-0.333-0.667-0.668-1.336-1.002-2.003c-1.001,0-2.003,0-3.006,0
                                      c0-0.334,0-0.669,0-1.002c-1.87-1.335-1.932-1.563-5.01-2.004c0-3.339,0-6.68,0-10.02c1.002-0.668,2.004-1.336,3.006-2.003
                                      c0-0.668,0-1.336,0-2.004c0.668-0.334,1.336-0.668,2.003-1.001c0-3.005,0-6.011,0-9.017c0.669-0.334,1.336-0.667,2.004-1.001
                                      c2.004-2.338,4.008-4.676,6.011-7.015c3.316,0.597,7.434,1.008,12.023,1.002c1.475,2.259,4.573,2.897,6.012,5.011
                                      c0.667,2.003,1.335,4.008,2.003,6.011c1.002,0.668,2.004,1.336,3.006,2.004c0,1.335,0,2.671,0,4.007
                                      c0.668,0.334,1.336,0.668,2.004,1.002c0,3.339,0,6.68,0,10.02C67.032,122.571,64.673,125.522,63.826,129.02z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M251.187,92.95c0,0.668,0,1.336,0,2.004c1.002,0,2.003,0,3.006,0c1.67,2.005,3.34,4.009,5.01,6.012
                                      c0.669,0.334,1.336,0.667,2.004,1.002c0,2.337,0,4.674,0,7.013c1.002,0.667,2.003,1.336,3.007,2.004
                                      c0.334,3.673,0.667,7.348,1.001,11.021c-2.337-0.668-4.676-1.336-7.013-2.004c0.551,2.031,0.762,2.822,2.004,4.008
                                      c0.667,0,1.335,0,2.003,0c0,0.334,0,0.668,0,1.001c-0.333,0-0.668,0-1.002,0c-3.722,5.749-17.656,4.156-27.053,4.008
                                      c-0.667-1.002-1.335-2.003-2.004-3.006c-0.332,0-0.668,0-1,0c-0.335-1.67-0.669-3.34-1.003-5.009
                                      c-0.668-0.334-1.336-0.668-2.005-1.002c0-3.339,0-6.681,0-10.02c0.336,0,0.669,0,1.004,0c0.333-1.67,0.667-3.34,1.001-5.01
                                      c1.003-0.667,2.003-1.335,3.006-2.003c0-1.001,0-2.004,0-3.006c1.001-0.667,2.005-1.336,3.007-2.003
                                      c0.666-1.002,1.334-2.004,2.003-3.007C241.39,92.717,245.606,92.867,251.187,92.95z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M34.77,134.029c5.343,0,10.688,0,16.03,0c0.334,0.668,0.668,1.336,1.003,2.004c1.335,0,2.671,0,4.007,0c0,0.334,0,0.668,0,1.002
                                      c1.002,0,2.004,0,3.006,0c1.335,1.67,2.671,3.34,4.008,5.01c1.002,0.667,2.003,1.336,3.005,2.003c0,1.002,0,2.004,0,3.006
                                      c0.667,0.334,1.336,0.667,2.004,1.002c0,6.679,0,13.36,0,20.039c-0.334,0-0.668,0-1.001,0c0,1.002,0,2.004,0,3.006
                                      c-1.336,1.002-2.672,2.004-4.008,3.005c0,0.668,0,1.336,0,2.004c-2.338,2.004-4.676,4.008-7.014,6.012c0,0.333,0,0.667,0,1.002
                                      c-1.67,0-3.34,0-5.01,0c-2.549,2.384-8.552,0.277-12.022,0c-2.06-3.109-6.042-3.737-8.016-7.014c-0.334,0-0.668,0-1.002,0
                                      c0-1.336,0-2.671,0-4.007c-0.333,0-0.667,0-1.002,0c0-0.668,0-1.336,0-2.003c-0.333,0-0.668,0-1.001,0c0-1.336,0-2.673,0-4.009
                                      c-0.333,0-0.668,0-1.002,0c0-2.004,0-4.007,0-6.011c-0.333,0-0.667,0-1.001,0c0-0.669,0-1.336,0-2.004c-0.334,0-0.668,0-1.002,0
                                      c0-5.009,0-10.02,0-15.029C28.521,141.078,32.679,137.687,34.77,134.029z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M271.226,141.043c0.335,1.002,0.668,2.003,1.002,3.005c0.334,0,0.668,0,1.001,0c0,1.002,0,2.004,0,3.006
                                      c0.67,0.334,1.337,0.667,2.005,1.002c0,4.675,0,9.352,0,14.027c-1.136,0.847-0.146-0.127-1.002,1.002c-1.003,0-2.004,0-3.006,0
                                      c0,1.335,0,2.672,0,4.007c-1.164,0.583-1.58,1.757-2.004,2.004c-1.002,0-2.003,0-3.005,0c0,0.333,0,0.668,0,1.002
                                      c2.045,1.342,1.881,1.64,2.003,5.009c-2.003,1.67-4.007,3.34-6.012,5.009c0,0.334,0,0.668,0,1.001c-1.002,0-2.003,0-3.006,0
                                      c-0.333,0.668-0.668,1.336-1.001,2.005c-2.672,0-5.344,0-8.016,0c-6.021,5.419-16.203-9.603-19.036-12.023
                                      c-0.335-6.011-0.669-12.024-1.003-18.035c0.334,0,0.668,0,1.003,0c0-2.672,0-5.345,0-8.016c2.003-1.669,4.008-3.34,6.01-5.01
                                      c0.334-0.668,0.668-1.335,1.003-2.004c2.005-0.334,4.008-0.667,6.012-1.002c0-0.333,0-0.668,0-1.002c0.668,0,1.335,0,2.005,0
                                      c0-0.333,0-0.667,0-1.002c5.343,0,10.686,0,16.029,0c0,0.334,0,0.668,0,1.002c1.001,0,2.005,0,3.006,0c0,0.334,0,0.668,0,1.002
                                      C268.445,139.559,266.056,140.235,271.226,141.043z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M35.771,323.396c0-0.668,0-1.336,0-2.005c-2.378,0.201-2.478,0.415-4.008,1.002c-0.333-1.002-0.668-2.004-1.001-3.006
                                      c-0.334,0-0.668,0-1.002,0c0-0.667,0-1.337,0-2.005c-0.667-0.333-1.335-0.666-2.003-1.001c-0.333-2.338-0.668-4.675-1.002-7.013
                                      c-0.667-0.334-1.336-0.669-2.003-1.003c0-7.012,0-14.027,0-21.039c0.334,0,0.667,0,1.002,0c0-0.668,0-1.336,0-2.004
                                      c0.668-0.335,1.335-0.669,2.004-1.003c0-1,0-2.004,0-3.005c0.333,0,0.668,0,1.001,0c0,0.333,0,0.666,0,1.001
                                      c1.878,0.942,4.222-0.56,5.01-1.001c0-0.335,0-0.669,0-1.003c1.002,0,2.004,0,3.005,0c0-0.334,0-0.668,0-1.002
                                      c0.334,0,0.669,0,1.002,0c0,0.334,0,0.668,0,1.002c2.003,0,4.007,0,6.012,0c0,0.334,0,0.668,0,1.003
                                      c2.003,0.333,4.007,0.666,6.01,1.001c0.669,1.004,1.336,2.004,2.005,3.007c0.333,0,0.667,0,1.002,0c0,0.668,0,1.336,0,2.004
                                      c0.667,0.334,1.335,0.668,2.003,1c0,1.005,0,2.005,0,3.008c0.668,0.333,1.336,0.667,2.004,1.001c0,3.005,0,6.011,0,9.018
                                      c0.667,0.333,1.336,0.666,2.004,1.002c0,0.669,0,1.335,0,2.004c0.334,0,0.667,0,1.001,0c-0.667,4.341-1.336,8.684-2.003,13.023
                                      c-1.928,1.035-4.092,3.174-6.011,4.009C47.718,323.171,41.33,323.365,35.771,323.396z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M244.174,285.322c2.24-0.601,2.508-0.837,4.008-2.003c0-0.336,0-0.67,0-1.004c0.668,0,1.336,0,2.004,0
                                      c0.332-0.668,0.668-1.336,1.001-2.004c3.34,0,6.681,0,10.02,0c0,0.334,0,0.668,0,1.003c2.339,0.333,4.676,0.666,7.014,1.001
                                      c0,0.334,0,0.668,0,1.004c5.275,4.333,3.144,21.779,3.006,31.059c-0.334,0-0.668,0-1.002,0c0,0.668,0,1.336,0,2.003
                                      c-0.334,0-0.668,0-1.002,0c-2.003,2.339-4.008,4.677-6.013,7.015c-5.008,0-10.02,0-15.027,0c-1.003-1.336-2.003-2.672-3.007-4.009
                                      c-0.667,0-1.337,0-2.005,0c-0.666-1.002-1.335-2.005-2.003-3.006c-0.668-0.334-1.336-0.667-2.004-1.003c0-4.007,0-8.015,0-12.021
                                      c4.082-3.716,1.14-8.75,3.007-14.025c0.334,0,0.669,0,1,0C243.506,287.994,243.838,286.658,244.174,285.322z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M254.192,329.407c-0.334,1.669-0.667,3.339-1.003,5.009c1.003,0.334,2.005,0.668,3.009,1.002c0,0.334,0,0.668,0,1.001
                                      c2.571,1.785,1.915-1.084,3.004,3.007c1.487,1.597,1.094,5.903,1.003,9.018c-2.499,2.277-0.691,2.801-2.004,5.009
                                      c-0.334,0-0.669,0-1.003,0c-0.668,1.003-1.336,2.005-2.004,3.006c-0.668,0-1.336,0-2.005,0c-0.667,1.002-1.335,2.005-2.003,3.007
                                      c-0.669,0-1.336,0-2.004,0c-0.333,0.668-0.668,1.336-1.001,2.003c-2.784,1.418-9.856,0.057-15.029,0
                                      c-3.518-5.687-8.575-4.124-9.019-14.027c3.45-2.553,0.331-1.747,2.005-5.009c0.668-0.334,1.335-0.669,2.003-1.003
                                      c0-0.667,0-1.336,0-2.003c0.669-0.334,1.337-0.667,2.005-1.001c0-2.006,0-4.009,0-6.012c0.668-0.334,1.335-0.669,2.003-1.003
                                      c0-0.668,0-1.336,0-2.003c0.669-0.335,1.337-0.668,2.004-1.003c0.668-1.002,1.336-2.004,2.006-3.006c4.008,0,8.015,0,12.022,0
                                      C249.464,327.022,251.819,328.801,254.192,329.407z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M46.792,326.4c5.01,0,10.021,0,15.031,0c1.001,1.337,2.003,2.672,3.005,4.009c0.334,0,0.668,0,1.002,0c0,1.335,0,2.671,0,4.007
                                      c0.667,0.334,1.336,0.668,2.004,1.002c0,1.67,0,3.341,0,5.011c1.002,0.667,2.004,1.334,3.006,2.003
                                      c1.628,2.583,1.928,6.871,2.004,11.021c-6.451,3.818-4.758,7.05-16.031,7.015c0,0.334,0,0.668,0,1.001c-1.67,0-3.34,0-5.009,0
                                      c-0.093,0.028,0.186,0.627-2.005,1.002c-2.14-3.057-1.423-0.424-4.007-2.003c-0.667-1.002-1.336-2.004-2.003-3.007
                                      c-4.926-4.81-7.94-7.131-8.016-17.031c3.054-2.108,0.537-1.06,2.004-4.01c0.334,0,0.668,0,1.002,0c0-0.667,0-1.335,0-2.003
                                      c0.668-0.334,1.336-0.668,2.004-1.002C42.785,331.076,44.789,328.739,46.792,326.4z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M220.127,391.527c-1.336,0-2.672,0-4.007,0c-3.189-5.32-7.942-5.096-8.017-14.029c-2.698-2.787-0.025-8.663,1.003-11.021
                                      c2.616-1.383,1.696-1.771,6.011-2.003c0-0.333,0-0.668,0-1.001c1.599-0.994,14.514,0.707,15.029,1.001
                                      c1.335,1.671,2.672,3.341,4.007,5.011c1.18,0.768,4.437,1.159,5.01,0c0,2.003,0,4.007,0,6.012
                                      c-3.567,2.661-1.283,4.292-3.004,8.014c-2.339,2.672-4.678,5.344-7.014,8.018c-2.339,0-4.675,0-7.016,0c0,0.333,0,0.668,0,1
                                      c-0.668,0.334-1.335,0.67-2.003,1.003C220.127,392.861,220.127,392.195,220.127,391.527z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M58.816,374.494c0.667,0,1.335,0,2.003,0c2.302-5.255,6.348-8.091,14.027-8.018c0-0.332,0-0.667,0-1c2.004,0,4.008,0,6.011,0
                                      c0,0.333,0,0.668,0,1c1.002,0,2.004,0,3.006,0c0.333,0.669,0.668,1.338,1.001,2.005c4.996,4.599,4.481,6.467,4.008,16.031
                                      c-2.447,1.563-0.612,1.14-2.003,3.006c-2.672,2.339-5.344,4.677-8.016,7.014c-4.007-0.334-8.016-0.667-12.023-1.002
                                      c-1.67-2.003-3.341-4.008-5.009-6.012c-0.335,0-0.669,0-1.003,0c0-1.002,0-2.004,0-3.006c-0.333,0-0.668,0-1.002,0
                                      c0-0.667,0-1.335,0-2.004c-0.334,0-0.667,0-1.001,0C58.816,379.837,58.816,377.165,58.816,374.494z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M208.104,399.542c-1.001,0-2.003,0-3.005,0c0.667,2.004,1.335,4.007,2.004,6.012c-0.334,0-0.669,0-1.002,0
                                      c-1.669,2.098-3.639,2.498-6.013,4.008c-0.333,0.667-0.669,1.335-1.001,2.004c-4.344,0-8.685,0-13.025,0
                                      c-0.991-1.657-4.69-4.34-5.011-5.011c0-3.674,0-7.348,0-11.021c1.142-1.142,0.399-0.004,1.003-2.004
                                      c1.669-1.335,3.34-2.673,5.011-4.008c0-0.335,0-0.669,0-1.002c0.666,0,1.335,0,2.004,0c0.333-0.667,0.668-1.336,1.001-2.004
                                      c4.341,0,8.682,0,13.024,0c1.671,2.004,3.34,4.008,5.01,6.011C208.104,394.866,208.104,397.204,208.104,399.542z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M91.879,389.522c8.146-0.188,13.693,0.775,19.037,3.005c0.651,1.176,1.636,1.441,2.003,2.005c0,0.668,0,1.336,0,2.004
                                      c0.668,0.333,1.336,0.668,2.004,1.002c0,4.008,0,8.016,0,12.023c-2.636,1.508-3.384,3.194-7.014,4.007c0,0.668,0,1.337,0,2.004
                                      c-4.007-0.667-8.017-1.336-12.023-2.004c-2.004-2.336-4.008-4.676-6.012-7.014c-0.667-0.334-1.335-0.668-2.003-1.001
                                      c0-3.675,0-7.348,0-11.021C90.06,393.328,91.172,392.324,91.879,389.522z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M177.043,420.583c-3.339,0.333-6.68,0.667-10.019,1.001c0,0.333,0,0.668,0,1.001c1.316,0.812,1.179,0.709,2.004,2.004
                                      c-0.668,0-1.337,0-2.004,0c-0.334,0.669-0.668,1.336-1.003,2.005c-3.005,0-6.01,0-9.017,0c-1.129-1.722-0.634-1.358-3.005-2.005
                                      c-0.236-2.583-0.129-3.435-1.003-5.009c-0.334,0-0.669,0-1.001,0c-1.029-2.545,1.26-13.776,2.004-15.029
                                      c1-0.667,2.003-1.334,3.005-2.004c1.745-1.805,4.403-1.998,8.016-2.003c1.001,1.335,2.004,2.673,3.007,4.007
                                      c0.667,0,1.336,0,2.004,0c1,1.336,2.004,2.673,3.004,4.009c0.669,0,1.336,0,2.004,0c0.669,1.002,1.337,2.004,2.004,3.006
                                      c0.336,0,0.668,0,1.004,0c0,1.671,0,3.34,0,5.011c-0.336,0-0.668,0-1.004,0C177.043,417.911,177.043,419.245,177.043,420.583z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="#000000" stroke-width="0.5" stroke-miterlimit="10" d="
                                      M134.962,402.547c2.003,0,4.008,0,6.012,0c1.002,1.337,2.004,2.673,3.006,4.008c0.334,0,0.668,0,1.001,0c0,6.011,0,12.023,0,18.034
                                      c-1.001,0.336-2.003,0.669-3.005,1.003c-0.333,0.667-0.667,1.337-1.002,2.006c-3.34,0-6.68,0-10.02,0c0-0.336,0-0.669,0-1.004
                                      c-1.669-0.335-3.339-0.669-5.009-1.002c-0.667-1.003-1.335-2.005-2.004-3.007c-4.14-3.743-4.138-0.161-4.008-9.017
                                      c3.674-3.34,7.348-6.68,11.021-10.02c1.335,0,2.672,0,4.008,0C134.962,403.217,134.962,402.881,134.962,402.547z"/>
                                </g>
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


