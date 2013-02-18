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
    .badge input{
        margin-top: -2px;
    }
</style>
<script type="text/javascript">
    $(function(){
   
        $('.ultima').datepicker();        
        $('.fecha').datepicker();        
        
        $("#agregarEnfermedad").click(function(){
            if(!$("#zonaeditar option:selected").val()){
                alert("Seleccione al menos una cara");
            }else{
                if($("input[name='enfermedad']:checked").length==""){
                    alert("Seleccione al menos una convención");
                }else{
                    $("#confirmacion").modal();
                    $("#diceSi").click(function(){
                        $("#confirmacion").modal("hide");
                        var idDiente = $("#dienteSeleccionado").text().split(" ");
                        $.ajax({
                            type: 'POST', 
                            url: "<%=request.getContextPath()%>/formController?action=agregarEnfermedad",
                            data: $("#formDiente").serialize()+"&diente="+idDiente[1]+"&realizar=Si",
                            success: function(){
                                $.ajax({
                                    type: 'POST', 
                                    url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                    success: function(data){
                                        $("#dibujarDiente").html(data);
                                    }
                                })
                            }
                        })
                    })
                    $("#diceNo").click(function(){
                        $("#confirmacion").modal("hide");
                        var idDiente = $("#dienteSeleccionado").text().split(" ");
                        $.ajax({
                            type: 'POST', 
                            url: "<%=request.getContextPath()%>/formController?action=agregarEnfermedad",
                            data: $("#formDiente").serialize()+"&diente="+idDiente[1]+"&realizar=No",
                            success: function(){
                                $.ajax({
                                    type: 'POST', 
                                    url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                    success: function(data){
                                        $("#dibujarDiente").html(data);
                                    }
                                })
                            }
                        })
                    })
                    
                }
           
            }        
        })    
        
            
            
        $("#eliminarEnfermedad").click(function(){
            if(!$("#zonaeditar option:selected").val()){
                alert("Seleccione al menos una cara");
            }else{
                if($("input[name='enfermedad']:checked").length==""){
                    alert("Seleccione al menos una convención");
                }else{
                    var idDiente = $("#dienteSeleccionado").text().split(" ");
            
                    $.ajax({
                        type: 'POST', 
                        url: "<%=request.getContextPath()%>/formController?action=eliminarEnfermedad",
                        data: $("#formDiente").serialize()+"&diente="+idDiente[1],
                        success: function(){
                            $.ajax({
                                type: 'POST', 
                                url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                success: function(data){
                                    $("#dibujarDiente").html(data);
                                }
                            })
                        }
                    })
                }
           
            }        
        })  
            
            
        
        
        $(".diente").click(function(ev){
            $('#zonaeditar option:selected').removeAttr("selected");
            $("#zonaSeleccionada").html("Zona Seleccionada:");  
            $('#derecha').modal();
            $("#dienteSeleccionado").text("Diente "+ $(this).attr("id"));
            if($(this).attr("id")>40 && $(this).attr("id")<49 || $(this).attr("id")>30 && $(this).attr("id")<39){
                $("#palatinaLingual").val("Lingual");
                $("#palatinaLingual").html("Lingual");
            }else{
                $("#palatinaLingual").val("Palatina");
                $("#palatinaLingual").html("Palatina");
            }
            var idDiente = $("#dienteSeleccionado").text().split(" ");
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=verDiente",
                data: "&diente="+idDiente[1],
                success: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                        success: function(data){
                            $("#dibujarDiente").html(data);
                        }
                    })
                }
            })
            
            
            
        });
        $('#derecha').on('hidden', function () {
            $.ajax({
                type: 'POST', 
                url: "<%=request.getContextPath()%>/formController?action=actualizaBoca",
                success: function(){
                    $.ajax({
                        type: 'POST', 
                        url: "/Odontogramas/vista/consulta/bocaAdulto.jsp",
                        success: function(data){
                            $("#bocaAdulto").empty();
                            setTimeout(function(){
                                $("#bocaAdulto").append(data);
                            }, 100);
                           
                    
                        } //fin success
                    }); //fin $.ajax    
                    
                } //fin success
            }); //fin $.ajax    
            
        });
        
        $(".parte").click(function(ev){
            //primer cuadrante
            var idDiente = $("#dienteSeleccionado").text().split(" ");
            if(idDiente[1]>20 && idDiente[1]<29){
                var parte = $(this).attr("id");
                if(parte=="oclusal1"){
                    
                    if($("#oclusal").attr("selected")){
                        $("#oclusal").attr("selected",false);    
                        
                    }else{
                        $("#oclusal").attr("selected",true);    
                    }
                    
                }else{
                    if(parte=="vestibular1"){
                        
                        if($("#vestibular").attr("selected")){
                            $("#vestibular").attr("selected",false);    
                        }else{
                            $("#vestibular").attr("selected",true);
                        }
                        
                    }else{
                        if(parte=="mesial1"){
                            
                            if($("#mesial").attr("selected")){
                                $("#mesial").attr("selected",false);    
                            }else{
                                $("#mesial").attr("selected",true);
                            }
                            
                        }else{
                            if(parte=="distal1"){
                                
                                if($("#distal").attr("selected")){
                                    $("#distal").attr("selected",false);
                                }else{
                                    $("#distal").attr("selected",true);    
                                }
                                
                            }else{
                                if(parte=="palatinaLingual1"){
                                    
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
            }else{
                //segundo cuadrante
                if(idDiente[1]>10 && idDiente[1]<19){
                    var parte = $(this).attr("id");
                    if(parte=="oclusal1"){
                        
                        if($("#oclusal").attr("selected")){
                            $("#oclusal").attr("selected",false);    
                        }else{
                            $("#oclusal").attr("selected",true);    
                        }
                    }else{
                        if(parte=="vestibular1"){
                            
                            if($("#vestibular").attr("selected")){
                                $("#vestibular").attr("selected",false);    
                            }else{
                                $("#vestibular").attr("selected",true);
                            }
                        
                        }else{
                            if(parte=="mesial1"){
                                
                                if($("#distal").attr("selected")){
                                    $("#distal").attr("selected",false);    
                                }else{
                                    $("#distal").attr("selected",true);
                                }
                            
                            }else{
                                if(parte=="distal1"){
                                    
                                    if($("#mesial").attr("selected")){
                                        $("#mesial").attr("selected",false);
                                    }else{
                                        $("#mesial").attr("selected",true);    
                                    }
                                
                                }else{
                                    if(parte=="palatinaLingual1"){
                                        
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
            
            
            $('#zonaeditar').change(function(e){
                var str="<i style='color:red'>";
                $("#zonaeditar option:selected").each(function () {
                    str += $(this).text() + "  ";
                })
        
                $("#zonaSeleccionada").html("Zona Seleccionada: "+str+" </i>");  
            })    
            
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
        <li ><a href="#odontoIn" data-toggle="tab">III. Odontograma Inicial</a></li>
        <li ><a href="#odontoFi" data-toggle="tab">IV. Odontograma Final</a></li>
        <li ><a href="#diag" data-toggle="tab">V. Diagnostico Y Tratamiento </a></li>
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
        <div class="tab-pane fade" id="odontoIn">
            <div class="span12">
                <form class="form-horizontal">
                    <fieldset>
                        <legend>Odontograma Inicial</legend>
                    </fieldset>
                </form>
                <div class="row">
                    <div class="span6">
                        <h3 style="margin-left: 20px;">Dentici&oacute;n permanente</h3>
                        <div id="bocaAdulto">
                            <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="256px"
                             height="480px" viewBox="0 0 256 480" enable-background="new 0 0 256 480" xml:space="preserve">
                        <image xlink:href="<%=request.getContextPath()%>/images/adultos.gif" height="480" width="256"/>
                        <path class="diente" id="21" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M123,31
                              c-2,0-4,0-6,0c-1.553-7.31-7.598-10.037-8-19c4.839-2.547,9.087-3.995,17-4c0.875,2.316,1.018,4.407,1,8
                              c-2.207,2.51-0.702,7.471-2,11c-0.333,0-0.667,0-1,0C123.667,28.333,123.333,29.667,123,31z"/>
                        <path class="diente" id="11" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M132,8
                              c6.937-0.156,11.367,1.057,16,3c0.333,1,0.667,2,1,3c-0.333,0-0.667,0-1,0c0,1.333,0,2.667,0,4c-0.333,0-0.667,0-1,0
                              c-0.333,1-0.667,2-1,3c-0.667,0.333-1.333,0.667-2,1c0,1.333,0,2.667,0,4c-0.667,0.333-1.333,0.667-2,1c-2.226,2.371-2.1,2.937-7,3
                              c-1.412-2.663-2.03-4.22-2-9c-0.333,0-0.667,0-1,0c-0.333-4-0.667-8-1-12c0.333,0,0.667,0,1,0C132,8.667,132,8.333,132,8z"/>
                        <path class="diente" id="22" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M101,16
                              c1.333,0,2.667,0,4,0c0.333,1,0.667,2,1,3c1.999,1.983,3.93,9.699,4,14c-3.122,1.816-3.387,2.982-9,3c-3.083-5.192-8.571-5.908-9-14
                              c1.333-1,2.667-2,4-3c0-0.333,0-0.667,0-1C98.228,16.694,98.791,18.546,101,16z"/>
                        <path class="diente" id="12" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M152,16
                              c2.666,0.333,5.334,0.667,8,1c2.494,3.68,5.646,2.669,6,9c-1,0.667-2,1.333-3,2c0,0.667,0,1.333,0,2c-2.333,1.667-4.667,3.333-7,5
                              c0,0.333,0,0.667,0,1c-1.333,0-2.667,0-4,0c-0.736-1.408-1.797-3.023-3-4c0-3,0-6,0-9C149.727,20.781,151.364,18.781,152,16z"/>
                        <path class="diente" id="23" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M81,46
                              c-0.587-2.239-0.836-2.506-2-4c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2c-0.667-0.333-1.333-0.667-2-1c-0.333-3-0.667-6-1-9
                              c1-0.333,2-0.667,3-1c2.05-1.885,9.224-1.1,13-1c0.667,1,1.333,2,2,3c0.333,0,0.667,0,1,0c2.035,3.18,2.019,8.737,2,14
                              c-4.073,2.366-3.755,3.073-11,3C83.744,46.091,83.986,46.341,81,46z"/>
                        <path class="diente" id="13" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M168,28
                              c4,0,8,0,12,0c0,0.333,0,0.667,0,1c0.333,0,0.667,0,1,0c0.333,3.333,0.667,6.667,1,10c-1.653,1.336-2.504,3.504-4,5
                              c-1.497,1.497-3.658,2.35-5,4c-2.666,0-5.334,0-8,0c-1.584-2.731-2.742-2.446-3-7c0.333,0,0.667,0,1,0c0-2.667,0-5.333,0-8
                              c0.333,0,0.667,0,1,0C165.333,31.333,166.667,29.667,168,28z"/>
                        <path class="diente" id="24" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M72,44
                              c1.333,0,2.667,0,4,0c1.838,2.573,5.846,3.885,7,7c1.969,5.316-2.922,17.98-5,19c-2,0-4,0-6,0c-4.333-2.667-8.667-5.333-13-8
                              c0-2,0-4,0-6c1-0.667,2-1.333,3-2c0-0.667,0-1.333,0-2c1.667-1.333,3.333-2.667,5-4c0.333-0.667,0.667-1.333,1-2
                              C69.669,44.844,70.285,46.006,72,44z"/>
                        <path class="diente" id="14" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M182,44
                              c1.666,0,3.334,0,5,0c4.362,6.566,11.742,6.381,12,18c-5.946,3.375-9.538,7.843-19,8c-2.508-5.632-4.913-9.506-5-18
                              c0.333,0,0.667,0,1,0c0-1,0-2,0-3C177.229,47.034,180.542,46.253,182,44z"/>
                        <path class="diente" id="25" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M55,66
                              c3,0.667,6,1.333,9,2c1.667,2,3.333,4,5,6c0.333,0,0.667,0,1,0c1.156,1.667-0.015,2.291,2,4c0.429,10.435-0.511,18.225-11,18
                              c0-0.333,0-0.667,0-1c-1.667-0.333-3.333-0.667-5-1c0-0.333,0-0.667,0-1c-0.667,0-1.333,0-2,0c-0.667-1-1.333-2-2-3
                              c-0.667,0-1.333,0-2,0c-0.333-0.667-0.667-1.333-1-2c-3.629-3.553-3.116-2.812-3-10c0.333,0,0.667,0,1,0c0.333-2,0.667-4,1-6
                              C50.333,70,52.667,68,55,66z"/>
                        <path class="diente" id="15" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M211,88
                              c-2.238,0.578-2.514,0.835-4,2c0,0.333,0,0.667,0,1c-0.667,0-1.333,0-2,0c-0.333,0.667-0.667,1.333-1,2c-0.667,0-1.333,0-2,0
                              c-3.292,1.694-5.843,2.817-11,3c-1.965-3.534-3.851-4.204-4-10c-0.333,0-0.667,0-1,0c0-2.667,0-5.333,0-8c0.333,0,0.667,0,1,0
                              c0.91-4.117,9.503-14.321,16-12c0,0.333,0,0.667,0,1c0.667,0,1.333,0,2,0c0.667,1,1.333,2,2,3c0.333,0,0.667,0,1,0c0,1,0,2,0,3
                              c1,0.667,2,1.333,3,2c0.333,3.667,0.667,7.333,1,11C210.861,87.139,211.602,86.003,211,88z"/>
                        <path class="diente" id="26" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M48,130
                              c0-0.667,0-1.333,0-2c-3.538-0.286-4.884-1.349-8-2c-0.528-0.918-3-3-3-3c0-5.666,0-11.334,0-17c0.333,0,0.667,0,1,0
                              c0-1.333,0-2.667,0-4c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c1.088-2.019,3.135-3.669,5-5c0-0.333,0-0.667,0-1c3,0,6,0,9,0
                              c3.272,3.681,8.382,4.477,11,9c4.868,4.669,0.086,16.764-1,22c-1.649,0.988-4.335,4.682-5,5C54.667,130,51.333,130,48,130z"/>
                        <path class="diente" id="16" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M205,94
                              c3,0,6,0,9,0c1.558,2.678,4.811,5.019,6,8c2.127,5.329,1.013,14.171,1,21c-1,0.667-2,1.333-3,2c0,0.333,0,0.667,0,1
                              c-2.922,1.916-13.223,3.867-18,4c-1-1.333-2-2.667-3-4c-0.333,0-0.667,0-1,0c-0.333-2.333-0.667-4.667-1-7
                              c-0.667-0.333-1.333-0.667-2-1c-0.333-4-0.667-8-1-12c0.333,0,0.667,0,1,0c0-1,0-2,0-3c0.333,0,0.667,0,1,0c1.666-2,3.334-4,5-6
                              c0.667,0,1.333,0,2,0c0-0.333,0-0.667,0-1C203.005,94.855,203.43,95.81,205,94z"/>
                        <path class="diente" id="27" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M29,156
                              c-0.333-2.667-0.667-5.333-1-8c0.333,0,0.667,0,1,0c0.333-4.333,0.667-8.667,1-13c5.729-3.439,2.617-5.084,13-5c0,0.333,0,0.667,0,1
                              c2,0.333,4,0.667,6,1c0,0.333,0,0.667,0,1c1.333,0.333,2.667,0.667,4,1c0,0.333,0,0.667,0,1c1.667,1.333,3.333,2.667,5,4
                              c0,2,0,4,0,6c2.452,2.627,0.274,9.513,0,13c-4.945,2.971-3.138,5.032-12,5c-2.157-1.875-5.807,0.217-9-1c0-0.333,0-0.667,0-1
                              c-0.667,0-1.333,0-2,0c0-0.333,0-0.667,0-1C32.905,158.35,31.989,156.811,29,156z"/>
                        <path class="diente" id="17" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M215,130
                              c3,0,6,0,9,0c0.781,1.433,2.771,4.012,4,5c0.262,4.533,2.76,11.489,1,17c-0.333,0-0.667,0-1,0c-0.333,1.667-0.667,3.333-1,5
                              c-1.333,1-2.667,2-4,3c0,0.333,0,0.667,0,1c-3.488,2.225-12.241,2.021-18,2c-2.11-3.522-4.662-3.33-5-9c-0.333,0-0.667,0-1,0
                              c0.333-4.666,0.667-9.334,1-14c0.333,0,0.667,0,1,0c1.054-3.91,2.848-4.206,6-6c0-0.333,0-0.667,0-1c0.667,0,1.333,0,2,0
                              c0-0.333,0-0.667,0-1c2-0.333,4-0.667,6-1C215,130.667,215,130.333,215,130z"/>
                        <path class="diente" id="28" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M54,192
                              c-1,0.333-2,0.667-3,1c0,0.333,0,0.667,0,1c-1,0-2,0-3,0c-0.333,0.667-0.667,1.333-1,2c-3.374,1.427-12.843-0.897-14-2
                              c-4.074-0.94-4.166-2.933-4-8c-1.046-1.069-1.956-7.444-1-10c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0
                              c0-1,0-2,0-3c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0
                              c1.334-1.492,0.491-1.39,3-2c2.414-2.242,8.219-0.217,12,0c2.099,3.092,1.43,0.431,4,2c1.667,2,3.333,4,5,6
                              c0.122,3.417,1.456,11.935,0,15c-0.333,0-0.667,0-1,0C54.908,189.646,54.635,189.68,54,192z"/>
                        <path class="diente" id="18" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M204,192
                              c-0.631-2.264-0.855-2.442-2-4c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2c-0.333,0-0.667,0-1,0c-0.421-1.681,0.954-1.777,1-2
                              c0.872-4.218,0.368-9.609,1-13c2.666-2,5.334-4,8-6c5.493-0.308,8.712-0.976,14,0c1.666,2.333,3.334,4.667,5,7c0,1,0,2,0,3
                              c0.333,0,0.667,0,1,0c-0.333,5.666-0.667,11.334-1,17c-1.801,0.944-1.574,1.385-4,2c-1.28,1.317-9.364,3.406-13,2
                              c0-0.333,0-0.667,0-1c-0.667,0-1.333,0-2,0c0-0.333,0-0.667,0-1C207.956,192.485,207.598,192.333,204,192z"/>
                        <path class="diente" id="38" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M29,293
                              c0.667,0,1.333,0,2,0c0.333-0.667,0.667-1.333,1-2c3.667,0,7.333,0,11,0c2.436,3.876,7.411,6.463,9,11
                              c2.569,7.336-4.246,12.681-8,14c-3.179,1.117-6.893-0.577-9-1c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0
                              C28.932,307.328,28.981,300.791,29,293z"/>
                        <path class="diente" id="48" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M214,291
                              c4,0,8,0,12,0c2.329,4.426,2.087,7.073,2,14c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-2.847,5.817-5.08,8.125-14,8c0-0.333,0-0.667,0-1
                              c-1,0-2,0-3,0c0-0.333,0-0.667,0-1c-2.074-1.632-3.199-1.929-4-5c-0.333,0-0.667,0-1,0c0-2.333,0-4.667,0-7
                              c2.001-1.721,0.843-2.322,2-4c0.667-0.333,1.333-0.667,2-1C210.666,295,212.334,293,214,291z"/>
                        <path class="diente" id="37" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M42,317
                              c3.826-0.038,6.271,0.478,9,1c0.655,1.181,1.622,1.426,2,2c0,0.667,0,1.333,0,2c0.667,0.333,1.333,0.667,2,1
                              c2.423,4.643,1.968,14.74,1,20c-6.777,4.04-3.736,7.058-16,7c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2
                              c-0.333,0-0.667,0-1,0c0-1.333,0-2.667,0-4c-2.424-7.201-2.98-13.708,0-21c1.007-0.493,1.834-1.915,2-2c1.333,0,2.667,0,4,0
                              C42,317.667,42,317.333,42,317z"/>
                        <path class="diente" id="47" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M207,317
                              c6.669-0.242,11.603-0.045,14,4c5.159,4.973,0.149,20.699-1,26c-4.072,2.366-3.755,3.072-11,3c-2.073-3.201-4.485-2.281-7-3
                              c-0.333-1-0.667-2-1-3c-0.333,0-0.667,0-1,0c0-1,0-2,0-3c-0.333,0-0.667,0-1,0c1-5.999,2-12.001,3-18c1-0.667,2-1.333,3-2
                              c0-0.667,0-1.333,0-2C205.42,318.38,206.324,318.206,207,317z"/>
                        <path class="diente" id="36" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M65,356
                              c1.212,5.808,6.633,18.622,0,23c0,0.333,0,0.667,0,1c-1.333,0-2.667,0-4,0c-0.333,0.667-0.667,1.333-1,2
                              c-2.279,1.803-4.781,1.989-9,2c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c-0.333-1.333-0.667-2.667-1-4
                              c-0.667-0.333-1.333-0.667-2-1c0-1.333,0-2.667,0-4c-2.07-5.98-3.186-10.225-2-17c4.736-2.119,8.781-3.902,16-4
                              c0.702,1.412,1.439,1.227,2,2c0,0.667,0,1.333,0,2C61.954,356.094,63.039,355.772,65,356z"/>
                        <path class="diente" id="46" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M197,351
                              c7.543-0.311,15.506,0.53,17,6c0.333,0,0.667,0,1,0c-0.333,4-0.667,8-1,12c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-0.333,0-0.667,0-1,0
                              c0,1,0,2,0,3c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-0.667,0.333-1.333,0.667-2,1c0,0.667,0,1.333,0,2c-1,0.667-2,1.333-3,2
                              c0,0.333,0,0.667,0,1c-2,0-4,0-6,0c-2.581-3.831-7.61-3.807-9-9c-0.333,0-0.667,0-1,0c0.667-5.333,1.333-10.667,2-16
                              c0.667-0.333,1.333-0.667,2-1c0.333-1.666,0.667-3.334,1-5c0.667,0,1.333,0,2,0C197,352.333,197,351.667,197,351z"/>
                        <path class="diente" id="35" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M61,385
                              c2,0,4,0,6,0c0.61,1.152,1.706,1.521,2,2c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0.333,2,0.667,4,1,6c0.333,0,0.667,0,1,0
                              c0,1.333,0,2.667,0,4c0.333,0,0.667,0,1,0c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0,2,0,4,0,6c-5.47,4.732-4.066,7.863-14,6
                              c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c-1.797-2.803-5.433-16.242-3-20C56.333,388.334,58.667,386.666,61,385z"/>
                        <path class="diente" id="45" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M190,385
                              c2,0,4,0,6,0c0,0.333,0,0.667,0,1c0.667,0,1.333,0,2,0c1.666,2,3.334,4,5,6c0.333,0,0.667,0,1,0c0,2.666,0,5.334,0,8
                              c-0.333,0-0.667,0-1,0c-0.333,2-0.667,4-1,6c-3.206,7.058-6.998,9.379-15,6c-1.936-4.629-3.002-5.896-3-13c0.333,0,0.667,0,1,0
                              c0.333-2.333,0.667-4.667,1-7c0.333,0,0.667,0,1,0C188.246,389.43,188.928,387.353,190,385z"/>
                        <path class="diente" id="34" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M77,409
                              c1,0,2,0,3,0c0.701,1.16,2.855,2.737,3,3c0.333,2,0.667,4,1,6c0.333,0,0.667,0,1,0c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0
                              c1.698,4.665,0.11,14.455-3,16c-2,0-4,0-6,0c-2.61-4.188-15.267-11.839-10-20c0.333,0,0.667,0,1,0
                              C70.631,412.734,74.458,411.985,77,409z"/>
                        <path class="diente" id="44" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M177,409
                              c1,0,2,0,3,0c0,0.333,0,0.667,0,1c5.15,1.128,10.986,6.378,11,13c-1.997,1.723-0.844,2.323-2,4c-3.666,3.333-7.334,6.667-11,10
                              c-5.426-2.079-7.824-4.74-8-12c1.767-2.017,0.83-5.403,2-8c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.667-0.333,1.333-0.667,2-1
                              c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0C176.333,411,176.667,410,177,409z"/>
                        <path class="diente" id="33" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M86,434
                              c5.658-1.31,5.227-2.376,11,0c1.335,3.57,1.047,9.913,1,15c-1.139,1.14-0.398,0.004-1,2c-2.437,0.918-6.193,1.037-10,1
                              c-0.333-1-0.667-2-1-3c-1.983-1.896-0.024-0.522-1-3C82.908,440.687,85.323,439.013,86,434z"/>
                        <path class="diente" id="43" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M171,434
                              c0.333,1.333,0.667,2.667,1,4c0.333,0,0.667,0,1,0c1.705,4.959-1.318,9.695-2,13c-2.437,0.918-6.193,1.037-10,1
                              c-0.333-1-0.667-2-1-3c-2.089-2.285-1.101-10.884-1-15c1.135-0.844,0.146,0.127,1-1c2.333-0.333,4.667-0.667,7-1
                              C168.165,433.361,168.824,433.528,171,434z"/>
                        <path class="diente" id="32" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M109,464
                              c-1.333,0-2.667,0-4,0c-2.82-4.167-6.592-2.795-7-10c2.364-1.982,3.36-5.292,6-7c0-0.333,0-0.667,0-1c1.667-0.333,3.333-0.667,5-1
                              c0,0.333,0,0.667,0,1C113.663,449.991,109.424,458.705,109,464z"/>
                        <path class="diente" id="42" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M148,464
                              c0-1.333,0-2.667,0-4c-0.667,0-1.333,0-2,0c0-4.333,0-8.667,0-13c1.867-0.706,3.91-0.993,7-1c2.351,4.258,5.644,5.552,6,12
                              C155.042,460.338,154.241,463.624,148,464z"/>
                        <path class="diente" id="31" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M126,470
                              c-3.667,0-7.333,0-11,0c-0.333-1-0.667-2-1-3c-1.807-1.927-0.969-5.779,0-8c0.333,0,0.667,0,1,0c0.333-2,0.667-4,1-6
                              c2.078-1.094,1.771-1.61,5-2c0.609,1.128,1.713,1.533,2,2c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0,1,0,2,0,3c0.333,0,0.667,0,1,0
                              c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0C126,463.333,126,466.667,126,470z"/>
                        <path class="diente" id="41" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M134,452
                              c1.666-0.333,3.334-0.667,5-1c0.844,1.135-0.127,0.146,1,1c0.413,5.313,2.936,9.347,4,14c-1,0.667-2,1.333-3,2
                              c-1.741,1.803-4.395,1.995-8,2c-0.706-1.867-0.993-3.91-1-7c0.333,0,0.667,0,1,0c0-3,0-6,0-9C133,454,133.691,453.834,134,452z"/>
                        <g id="incluido">
                        <c:choose>
                            <c:when test="${dientesEnfermos.getRowCount()== 0}">

                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${dientesEnfermos.rowsByIndex}" var="diente" varStatus="iter">
                                    <c:choose>
                                        <c:when test="${diente[0]==11}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="140.521" cy="14.755" rx="10.479" ry="6.866"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="140.515" cy="14.14" rx="6.485" ry="5.139"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="129.681" y="6.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="22.353" height="14.672"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="129.033" y1="17.504" x2="157.357" y2="16.011"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M141.411,10.841v2.061h-0.163c-0.053-0.396-0.147-0.71-0.283-0.945
                                                          s-0.33-0.42-0.582-0.558s-0.513-0.207-0.782-0.207c-0.304,0-0.556,0.093-0.755,0.279c-0.199,0.187-0.299,0.398-0.299,0.635
                                                          c0,0.182,0.063,0.347,0.188,0.497c0.182,0.22,0.614,0.513,1.296,0.879c0.557,0.299,0.937,0.528,1.14,0.688
                                                          c0.204,0.16,0.36,0.348,0.471,0.565c0.109,0.217,0.164,0.444,0.164,0.681c0,0.451-0.175,0.84-0.524,1.167s-0.8,0.49-1.351,0.49
                                                          c-0.173,0-0.336-0.013-0.487-0.04c-0.091-0.015-0.279-0.068-0.564-0.16c-0.286-0.093-0.467-0.139-0.543-0.139
                                                          c-0.073,0-0.131,0.022-0.174,0.066c-0.042,0.044-0.073,0.135-0.094,0.272h-0.163v-2.043h0.163c0.076,0.428,0.179,0.748,0.307,0.96
                                                          c0.129,0.213,0.326,0.389,0.591,0.53c0.266,0.141,0.556,0.211,0.872,0.211c0.366,0,0.655-0.097,0.868-0.29
                                                          c0.212-0.193,0.318-0.422,0.318-0.686c0-0.146-0.04-0.294-0.121-0.444c-0.08-0.149-0.206-0.289-0.375-0.417
                                                          c-0.114-0.088-0.427-0.275-0.937-0.56c-0.509-0.286-0.871-0.514-1.087-0.684c-0.215-0.17-0.378-0.357-0.489-0.563
                                                          s-0.167-0.431-0.167-0.677c0-0.428,0.164-0.796,0.492-1.105c0.327-0.309,0.745-0.463,1.251-0.463c0.316,0,0.652,0.078,1.006,0.233
                                                          c0.164,0.073,0.28,0.11,0.348,0.11c0.076,0,0.138-0.022,0.187-0.068c0.048-0.045,0.087-0.137,0.116-0.275H141.411z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M139.958,14.636l1.278,1.907c0.354,0.527,0.617,0.861,0.789,1
                                                          c0.171,0.14,0.389,0.216,0.652,0.231v0.163h-2.557v-0.163c0.17-0.003,0.296-0.021,0.378-0.053
                                                          c0.062-0.026,0.111-0.066,0.151-0.121c0.039-0.054,0.059-0.109,0.059-0.165c0-0.067-0.013-0.135-0.039-0.202
                                                          c-0.021-0.05-0.101-0.179-0.241-0.387l-1.011-1.529l-1.247,1.6c-0.132,0.17-0.211,0.283-0.237,0.341
                                                          c-0.026,0.057-0.04,0.116-0.04,0.178c0,0.094,0.04,0.171,0.119,0.233s0.229,0.097,0.452,0.105v0.163h-2.113v-0.163
                                                          c0.149-0.015,0.278-0.045,0.387-0.092c0.182-0.076,0.354-0.179,0.519-0.308s0.352-0.327,0.563-0.593l1.405-1.775l-1.173-1.718
                                                          c-0.319-0.466-0.59-0.771-0.813-0.916c-0.223-0.146-0.479-0.222-0.769-0.231v-0.163h2.754v0.163
                                                          c-0.234,0.009-0.395,0.047-0.48,0.114c-0.087,0.067-0.13,0.142-0.13,0.224c0,0.108,0.07,0.267,0.211,0.475l0.913,1.367l1.059-1.34
                                                          c0.123-0.158,0.199-0.267,0.227-0.325c0.028-0.059,0.042-0.119,0.042-0.18s-0.018-0.116-0.053-0.163
                                                          c-0.044-0.062-0.1-0.104-0.167-0.13c-0.067-0.024-0.207-0.039-0.417-0.042v-0.163h2.112v0.163
                                                          c-0.167,0.009-0.303,0.035-0.408,0.079c-0.158,0.067-0.304,0.158-0.435,0.272c-0.132,0.114-0.318,0.325-0.559,0.633
                                                          L139.958,14.636z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M139.166,11.303v2.355h1.31c0.339,0,0.566-0.051,0.681-0.154
                                                          c0.152-0.135,0.237-0.372,0.255-0.712h0.162v2.074h-0.162c-0.041-0.29-0.082-0.476-0.123-0.558
                                                          c-0.053-0.103-0.14-0.183-0.26-0.242s-0.305-0.088-0.553-0.088h-1.31v1.964c0,0.264,0.012,0.424,0.035,0.481
                                                          c0.023,0.057,0.064,0.103,0.123,0.136c0.059,0.034,0.17,0.051,0.334,0.051h1.01c0.337,0,0.582-0.023,0.734-0.07
                                                          c0.151-0.047,0.298-0.139,0.438-0.277c0.182-0.182,0.368-0.456,0.559-0.822h0.176l-0.515,1.494h-4.59v-0.163h0.211
                                                          c0.141,0,0.273-0.034,0.399-0.101c0.094-0.047,0.157-0.117,0.191-0.211c0.033-0.094,0.051-0.286,0.051-0.576v-3.872
                                                          c0-0.378-0.038-0.611-0.114-0.699c-0.105-0.117-0.281-0.176-0.527-0.176h-0.211v-0.163h4.59l0.066,1.305h-0.172
                                                          c-0.062-0.313-0.129-0.529-0.204-0.646c-0.074-0.117-0.185-0.207-0.331-0.268c-0.117-0.044-0.324-0.066-0.62-0.066H139.166z"/>
                                                    </g>

                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M142.781,5.101c0.099-0.022,0.201,0.006,0.309,0.085
                                                          c0.08,0.07,0.13,0.151,0.151,0.242c0.04,0.176-0.037,0.434-0.231,0.775c-0.075,0.161-0.146,0.306-0.213,0.433
                                                          c-0.066,0.128-0.213,0.397-0.439,0.81c-0.74,1.316-2.079,4.059-4.015,8.229c-1.279,2.745-2.315,5.022-3.11,6.832
                                                          c-0.735,1.795-1.461,3.557-2.18,5.284l-0.838,2.056c-0.292,0.756-0.453,1.189-0.483,1.301c-0.093,0.294-0.231,0.461-0.414,0.503
                                                          c-0.243,0.056-0.39-0.023-0.438-0.236c-0.058-0.251,0.106-0.881,0.492-1.892c1.188-3.141,2.985-7.34,5.395-12.597
                                                          c2.643-5.743,4.337-9.256,5.084-10.542c0.301-0.51,0.479-0.815,0.535-0.916C142.528,5.25,142.659,5.128,142.781,5.101z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M150.637,3.302c0.099-0.023,0.201,0.005,0.308,0.085
                                                          c0.08,0.07,0.131,0.15,0.151,0.242c0.04,0.175-0.037,0.434-0.23,0.774c-0.075,0.161-0.146,0.306-0.213,0.433
                                                          c-0.066,0.128-0.213,0.398-0.439,0.811c-0.74,1.315-2.079,4.058-4.016,8.229c-1.278,2.746-2.314,5.023-3.109,6.832
                                                          c-0.735,1.795-1.461,3.557-2.18,5.284l-0.838,2.056c-0.292,0.756-0.453,1.189-0.484,1.301c-0.093,0.293-0.23,0.461-0.413,0.503
                                                          c-0.243,0.056-0.39-0.022-0.438-0.236c-0.059-0.251,0.106-0.882,0.492-1.892c1.187-3.141,2.985-7.34,5.394-12.597
                                                          c2.644-5.742,4.338-9.256,5.085-10.541c0.301-0.51,0.479-0.815,0.535-0.916C150.383,3.452,150.515,3.33,150.637,3.302z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="130.705" y1="12.323" x2="150.326" y2="12.073"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="130.705" y1="16.206" x2="150.326" y2="15.956"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==12}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="157.521" cy="22.755" rx="10.479" ry="6.866"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="158.015" cy="22.537" rx="6.985" ry="5.535"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="144.681" y="13.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="25.353" height="16.641"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="143.195" y1="25.504" x2="175.952" y2="22.824"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M159.869,19.164v2.29h-0.181c-0.059-0.439-0.163-0.79-0.314-1.05
                                                          s-0.367-0.467-0.647-0.62c-0.279-0.153-0.569-0.229-0.868-0.229c-0.339,0-0.618,0.104-0.84,0.31
                                                          c-0.221,0.207-0.332,0.442-0.332,0.706c0,0.202,0.07,0.386,0.21,0.552c0.202,0.244,0.682,0.57,1.44,0.977
                                                          c0.618,0.332,1.04,0.587,1.267,0.764c0.226,0.177,0.399,0.387,0.521,0.627s0.184,0.493,0.184,0.757
                                                          c0,0.501-0.194,0.934-0.584,1.296c-0.389,0.363-0.889,0.544-1.5,0.544c-0.192,0-0.373-0.015-0.542-0.044
                                                          c-0.101-0.016-0.31-0.076-0.627-0.178s-0.519-0.154-0.604-0.154c-0.081,0-0.146,0.024-0.192,0.073s-0.082,0.15-0.104,0.303h-0.181
                                                          v-2.271h0.181c0.084,0.475,0.198,0.831,0.341,1.067c0.144,0.236,0.362,0.432,0.657,0.588c0.294,0.156,0.617,0.234,0.969,0.234
                                                          c0.406,0,0.728-0.107,0.964-0.322c0.235-0.215,0.354-0.469,0.354-0.762c0-0.163-0.045-0.327-0.134-0.493
                                                          c-0.09-0.166-0.229-0.321-0.418-0.464c-0.127-0.098-0.473-0.305-1.039-0.623s-0.969-0.57-1.208-0.759s-0.421-0.397-0.544-0.625
                                                          c-0.124-0.228-0.186-0.479-0.186-0.752c0-0.475,0.182-0.885,0.546-1.228c0.365-0.343,0.828-0.515,1.392-0.515
                                                          c0.352,0,0.724,0.086,1.117,0.259c0.183,0.082,0.311,0.122,0.386,0.122c0.085,0,0.154-0.025,0.208-0.076s0.097-0.152,0.129-0.305
                                                          H159.869z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M158.366,23.27l1.42,2.119c0.395,0.586,0.687,0.956,0.877,1.111
                                                          c0.189,0.155,0.432,0.24,0.725,0.256v0.181h-2.841v-0.181c0.188-0.003,0.329-0.023,0.42-0.059
                                                          c0.068-0.029,0.124-0.074,0.168-0.134s0.066-0.121,0.066-0.183c0-0.075-0.015-0.15-0.044-0.225
                                                          c-0.023-0.055-0.112-0.199-0.269-0.43l-1.123-1.699l-1.386,1.777c-0.146,0.189-0.234,0.315-0.264,0.378s-0.044,0.129-0.044,0.198
                                                          c0,0.104,0.044,0.19,0.132,0.259s0.256,0.107,0.503,0.117v0.181h-2.348v-0.181c0.166-0.016,0.309-0.05,0.43-0.103
                                                          c0.201-0.084,0.394-0.199,0.576-0.342c0.182-0.143,0.39-0.363,0.624-0.659l1.562-1.973l-1.303-1.909
                                                          c-0.354-0.518-0.655-0.857-0.902-1.018c-0.248-0.161-0.532-0.247-0.854-0.256v-0.181h3.06v0.181
                                                          c-0.26,0.01-0.438,0.052-0.534,0.127s-0.144,0.158-0.144,0.249c0,0.121,0.078,0.296,0.234,0.527l1.015,1.519l1.177-1.489
                                                          c0.137-0.176,0.22-0.296,0.251-0.361s0.047-0.132,0.047-0.2s-0.02-0.128-0.059-0.181c-0.049-0.068-0.111-0.116-0.186-0.144
                                                          c-0.075-0.028-0.229-0.043-0.464-0.046v-0.181h2.348v0.181c-0.186,0.01-0.337,0.039-0.454,0.088
                                                          c-0.176,0.075-0.337,0.176-0.483,0.303s-0.353,0.361-0.619,0.703L158.366,23.27z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M157.375,19.677v2.617h1.454c0.378,0,0.63-0.057,0.757-0.171
                                                          c0.169-0.15,0.264-0.414,0.283-0.791h0.181v2.305h-0.181c-0.046-0.322-0.091-0.529-0.137-0.62
                                                          c-0.059-0.114-0.154-0.204-0.288-0.269s-0.338-0.098-0.615-0.098h-1.454v2.183c0,0.293,0.013,0.471,0.039,0.535
                                                          s0.071,0.114,0.137,0.151s0.188,0.056,0.371,0.056h1.122c0.374,0,0.646-0.026,0.815-0.078s0.332-0.155,0.488-0.308
                                                          c0.201-0.202,0.408-0.506,0.619-0.913h0.195l-0.57,1.66h-5.101v-0.181h0.234c0.156,0,0.304-0.038,0.444-0.112
                                                          c0.104-0.052,0.175-0.13,0.212-0.234s0.056-0.317,0.056-0.64v-4.302c0-0.42-0.042-0.679-0.126-0.776
                                                          c-0.117-0.13-0.313-0.195-0.586-0.195h-0.234v-0.181h5.101l0.073,1.45h-0.19c-0.068-0.348-0.145-0.587-0.228-0.718
                                                          s-0.206-0.229-0.368-0.298c-0.13-0.049-0.359-0.073-0.688-0.073H157.375z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M163.374,13.832c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.21,0.266-0.304,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.933,3.492-5.751,7.125c-1.859,2.391-3.378,4.379-4.557,5.965
                                                          c-1.117,1.586-2.218,3.141-3.304,4.664l-1.276,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.858-2.797,4.549-6.488,8.07-11.074
                                                          c3.858-5.008,6.294-8.055,7.31-9.141c0.406-0.43,0.648-0.688,0.727-0.773C163.094,13.922,163.249,13.832,163.374,13.832z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M171.433,13.832c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.21,0.266-0.304,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.933,3.492-5.751,7.125c-1.859,2.391-3.378,4.379-4.557,5.965
                                                          c-1.117,1.586-2.218,3.141-3.304,4.664l-1.276,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.858-2.797,4.549-6.488,8.07-11.074
                                                          c3.858-5.008,6.294-8.055,7.31-9.141c0.406-0.43,0.648-0.688,0.727-0.773C171.152,13.922,171.308,13.832,171.433,13.832z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="87.47" y1="21.719" x2="113.884" y2="21.469"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="87.47" y1="25.602" x2="113.884" y2="25.352"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==13}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="174.021" cy="36.394" rx="12.979" ry="8.503"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="174.632" cy="36.323" rx="8.985" ry="7.12"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="158.681" y="26.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="30.353" height="19.923"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="154.021" y1="39.834" x2="189.033" y2="34.27"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M177.492,31.288v3.601h-0.284c-0.092-0.691-0.257-1.241-0.495-1.65
                                                          c-0.237-0.41-0.577-0.734-1.017-0.975c-0.44-0.241-0.896-0.361-1.366-0.361c-0.532,0-0.972,0.163-1.319,0.487
                                                          c-0.349,0.325-0.522,0.695-0.522,1.109c0,0.317,0.11,0.606,0.33,0.868c0.317,0.384,1.072,0.896,2.264,1.536
                                                          c0.973,0.522,1.636,0.922,1.991,1.201c0.355,0.279,0.63,0.608,0.821,0.987c0.192,0.379,0.288,0.775,0.288,1.19
                                                          c0,0.788-0.306,1.468-0.917,2.038c-0.611,0.571-1.398,0.856-2.359,0.856c-0.303,0-0.586-0.023-0.853-0.069
                                                          c-0.158-0.026-0.487-0.119-0.985-0.28c-0.499-0.161-0.815-0.242-0.948-0.242c-0.128,0-0.229,0.038-0.303,0.115
                                                          c-0.074,0.077-0.13,0.235-0.165,0.476h-0.284v-3.57h0.284c0.133,0.748,0.312,1.307,0.537,1.678
                                                          c0.225,0.371,0.569,0.679,1.032,0.925s0.971,0.369,1.523,0.369c0.639,0,1.145-0.169,1.515-0.507
                                                          c0.371-0.338,0.557-0.737,0.557-1.198c0-0.256-0.07-0.514-0.211-0.775c-0.141-0.261-0.359-0.504-0.656-0.729
                                                          c-0.199-0.154-0.744-0.48-1.635-0.979c-0.89-0.499-1.522-0.897-1.898-1.194s-0.662-0.625-0.856-0.982
                                                          c-0.194-0.358-0.291-0.752-0.291-1.183c0-0.747,0.286-1.391,0.859-1.931s1.302-0.81,2.187-0.81c0.553,0,1.139,0.136,1.758,0.407
                                                          c0.286,0.128,0.488,0.192,0.606,0.192c0.133,0,0.241-0.04,0.326-0.119c0.084-0.08,0.152-0.239,0.203-0.48H177.492z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M175.701,37.171l2.233,3.332c0.619,0.921,1.078,1.503,1.378,1.747
                                                          c0.299,0.243,0.679,0.377,1.139,0.403v0.284h-4.466v-0.284c0.297-0.005,0.517-0.036,0.66-0.092
                                                          c0.107-0.046,0.195-0.117,0.265-0.211s0.104-0.19,0.104-0.288c0-0.118-0.023-0.235-0.069-0.354
                                                          c-0.035-0.087-0.176-0.312-0.422-0.675l-1.765-2.672l-2.18,2.794c-0.23,0.297-0.368,0.495-0.414,0.595
                                                          c-0.046,0.1-0.069,0.203-0.069,0.311c0,0.164,0.069,0.299,0.207,0.407c0.139,0.107,0.401,0.169,0.791,0.184v0.284h-3.691v-0.284
                                                          c0.261-0.025,0.486-0.079,0.675-0.161c0.317-0.133,0.619-0.312,0.906-0.538c0.286-0.225,0.613-0.57,0.981-1.036l2.456-3.102
                                                          l-2.049-3.002c-0.558-0.814-1.031-1.348-1.42-1.601c-0.389-0.253-0.836-0.388-1.343-0.403v-0.284h4.812v0.284
                                                          c-0.409,0.016-0.689,0.082-0.84,0.2c-0.151,0.118-0.227,0.248-0.227,0.392c0,0.189,0.122,0.466,0.368,0.829l1.596,2.388
                                                          l1.85-2.342c0.215-0.276,0.347-0.465,0.396-0.568s0.073-0.208,0.073-0.315s-0.031-0.202-0.093-0.284
                                                          c-0.076-0.107-0.174-0.183-0.291-0.226c-0.118-0.043-0.361-0.068-0.729-0.073v-0.284h3.691v0.284
                                                          c-0.292,0.016-0.529,0.062-0.714,0.138c-0.276,0.118-0.529,0.276-0.76,0.476s-0.555,0.568-0.975,1.105L175.701,37.171z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M173.57,32.094v4.115h2.287c0.594,0,0.99-0.09,1.189-0.269
                                                          c0.266-0.235,0.414-0.65,0.445-1.244h0.283v3.624h-0.283c-0.072-0.506-0.144-0.832-0.215-0.975
                                                          c-0.093-0.179-0.243-0.32-0.453-0.422s-0.532-0.154-0.967-0.154h-2.287v3.432c0,0.46,0.021,0.741,0.062,0.84
                                                          c0.041,0.1,0.112,0.179,0.215,0.238c0.103,0.059,0.297,0.088,0.583,0.088h1.766c0.588,0,1.016-0.041,1.281-0.123
                                                          s0.521-0.243,0.768-0.484c0.317-0.317,0.642-0.795,0.975-1.436h0.307l-0.897,2.61h-8.02v-0.284h0.368
                                                          c0.246,0,0.479-0.059,0.698-0.176c0.164-0.082,0.275-0.205,0.334-0.369s0.088-0.499,0.088-1.006v-6.764
                                                          c0-0.66-0.066-1.067-0.199-1.221c-0.184-0.205-0.491-0.307-0.921-0.307h-0.368v-0.284h8.02l0.115,2.28h-0.3
                                                          c-0.107-0.547-0.227-0.924-0.356-1.128c-0.131-0.205-0.324-0.361-0.58-0.468c-0.204-0.077-0.564-0.115-1.082-0.115H173.57z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M178.374,25.832c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.21,0.266-0.304,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.933,3.492-5.751,7.125c-1.859,2.391-3.378,4.379-4.557,5.965
                                                          c-1.117,1.586-2.218,3.141-3.304,4.664l-1.276,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.858-2.797,4.549-6.488,8.07-11.074
                                                          c3.858-5.008,6.294-8.055,7.31-9.141c0.406-0.43,0.648-0.688,0.727-0.773C178.094,25.922,178.249,25.832,178.374,25.832z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M186.433,25.832c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.21,0.266-0.304,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.933,3.492-5.751,7.125c-1.859,2.391-3.378,4.379-4.557,5.965
                                                          c-1.117,1.586-2.218,3.141-3.304,4.664l-1.276,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.858-2.797,4.549-6.488,8.07-11.074
                                                          c3.858-5.008,6.294-8.055,7.31-9.141c0.406-0.43,0.648-0.688,0.727-0.773C186.152,25.922,186.308,25.832,186.433,25.832z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="157.586" y1="34.689" x2="191.676" y2="34.439"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="157.586" y1="38.572" x2="191.676" y2="38.322"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==14}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="186.021" cy="56.359" rx="15.979" ry="10.469"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="186.132" cy="56.304" rx="11.485" ry="9.101"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="168.681" y="44.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="35.353" height="23.205"/>

                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="166.132" y1="63.075" x2="207.857" y2="49.654"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>



                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M202.915,73.097v4.809h-0.38c-0.123-0.923-0.344-1.658-0.66-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.44,1.159c0.424,0.513,1.433,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.66,1.604c0.476,0.373,0.842,0.812,1.098,1.318s0.385,1.036,0.385,1.589
                                                          c0,1.053-0.408,1.96-1.225,2.723c-0.818,0.762-1.869,1.143-3.154,1.143c-0.402,0-0.782-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.317-0.374c-0.666-0.216-1.089-0.323-1.267-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          s-0.172,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.418,1.745,0.719,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          c0.618,0.328,1.297,0.492,2.035,0.492c0.854,0,1.529-0.226,2.025-0.677c0.495-0.451,0.743-0.984,0.743-1.6
                                                          c0-0.342-0.095-0.687-0.282-1.036s-0.48-0.673-0.877-0.974c-0.266-0.205-0.994-0.641-2.184-1.307
                                                          c-1.189-0.667-2.035-1.198-2.537-1.595c-0.504-0.396-0.885-0.834-1.145-1.313s-0.389-1.005-0.389-1.579
                                                          c0-0.998,0.383-1.857,1.148-2.579c0.766-0.721,1.739-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543
                                                          c0.383,0.171,0.653,0.256,0.811,0.256c0.178,0,0.322-0.053,0.436-0.159s0.203-0.32,0.271-0.641H202.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>

                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M104.552,456.066l1.137,1.695c0.315,0.469,0.549,0.766,0.701,0.889
                                                          c0.152,0.124,0.346,0.192,0.58,0.205V459h-2.273v-0.145c0.151-0.002,0.263-0.018,0.336-0.047c0.055-0.023,0.1-0.059,0.135-0.107
                                                          c0.035-0.048,0.053-0.097,0.053-0.146c0-0.06-0.012-0.119-0.035-0.18c-0.018-0.044-0.09-0.158-0.215-0.344l-0.898-1.359
                                                          l-1.109,1.422c-0.117,0.151-0.188,0.252-0.211,0.303s-0.035,0.104-0.035,0.158c0,0.084,0.035,0.152,0.105,0.207
                                                          s0.205,0.086,0.402,0.094V459h-1.879v-0.145c0.133-0.013,0.248-0.04,0.344-0.082c0.162-0.067,0.315-0.158,0.461-0.273
                                                          c0.146-0.114,0.313-0.29,0.5-0.527l1.25-1.578l-1.043-1.527c-0.284-0.414-0.525-0.686-0.723-0.814s-0.426-0.197-0.684-0.205
                                                          v-0.145h2.449v0.145c-0.208,0.008-0.351,0.042-0.428,0.102c-0.077,0.061-0.115,0.127-0.115,0.199c0,0.097,0.063,0.237,0.188,0.422
                                                          l0.813,1.215l0.941-1.191c0.109-0.141,0.176-0.236,0.201-0.289c0.025-0.052,0.037-0.105,0.037-0.16s-0.016-0.103-0.047-0.145
                                                          c-0.039-0.055-0.088-0.093-0.148-0.115c-0.06-0.021-0.184-0.034-0.371-0.037v-0.145h1.879v0.145
                                                          c-0.148,0.008-0.27,0.031-0.363,0.07c-0.141,0.061-0.27,0.141-0.387,0.242s-0.283,0.289-0.496,0.563L104.552,456.066z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M185.201,50.889v5.015h2.726c0.707,0,1.18-0.109,1.417-0.328
                                                          c0.317-0.287,0.494-0.792,0.53-1.516h0.339v4.416h-0.339c-0.085-0.618-0.171-1.014-0.256-1.188
                                                          c-0.109-0.218-0.29-0.39-0.539-0.515c-0.251-0.125-0.635-0.187-1.152-0.187h-2.726v4.182c0,0.561,0.024,0.903,0.073,1.024
                                                          s0.134,0.218,0.256,0.29s0.354,0.107,0.695,0.107h2.104c0.701,0,1.21-0.05,1.527-0.149c0.316-0.1,0.621-0.296,0.914-0.589
                                                          c0.378-0.387,0.765-0.97,1.161-1.75h0.366l-1.07,3.181h-9.557v-0.346h0.439c0.292,0,0.569-0.072,0.832-0.215
                                                          c0.195-0.1,0.327-0.249,0.397-0.449s0.105-0.608,0.105-1.226v-8.242c0-0.805-0.079-1.301-0.237-1.488
                                                          c-0.22-0.249-0.586-0.374-1.098-0.374h-0.439v-0.346h9.557l0.138,2.778h-0.357c-0.128-0.667-0.27-1.125-0.425-1.375
                                                          s-0.386-0.44-0.69-0.571c-0.244-0.093-0.674-0.14-1.289-0.14H185.201z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M191.108,45.778c0.1,0,0.191,0.051,0.275,0.152
                                                          c0.061,0.086,0.092,0.176,0.092,0.27c0,0.18-0.13,0.414-0.39,0.703c-0.107,0.141-0.206,0.266-0.298,0.375s-0.29,0.34-0.596,0.691
                                                          c-0.993,1.117-2.868,3.492-5.624,7.125c-1.818,2.391-3.304,4.379-4.456,5.965c-1.093,1.586-2.169,3.141-3.23,4.664l-1.249,1.816
                                                          c-0.442,0.672-0.691,1.059-0.744,1.16c-0.153,0.266-0.321,0.398-0.504,0.398c-0.245,0-0.367-0.109-0.367-0.328
                                                          c0-0.258,0.294-0.836,0.882-1.734c1.818-2.797,4.448-6.488,7.893-11.074c3.772-5.008,6.155-8.055,7.148-9.141
                                                          c0.396-0.43,0.634-0.688,0.71-0.773C190.834,45.868,190.986,45.778,191.108,45.778z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M198.989,45.778c0.1,0,0.191,0.051,0.275,0.152
                                                          c0.061,0.086,0.092,0.176,0.092,0.27c0,0.18-0.13,0.414-0.39,0.703c-0.107,0.141-0.206,0.266-0.298,0.375s-0.29,0.34-0.596,0.691
                                                          c-0.993,1.117-2.868,3.492-5.624,7.125c-1.818,2.391-3.304,4.379-4.456,5.965c-1.093,1.586-2.169,3.141-3.23,4.664l-1.249,1.816
                                                          c-0.442,0.672-0.691,1.059-0.744,1.16c-0.153,0.266-0.321,0.398-0.504,0.398c-0.245,0-0.367-0.109-0.367-0.328
                                                          c0-0.258,0.294-0.836,0.882-1.734c1.818-2.797,4.448-6.488,7.893-11.074c3.772-5.008,6.155-8.055,7.148-9.141
                                                          c0.396-0.43,0.634-0.688,0.71-0.773C198.715,45.868,198.867,45.778,198.989,45.778z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="166.133" y1="54.487" x2="204.516" y2="54.237"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="166.133" y1="58.37" x2="204.516" y2="58.12"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==15}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="200.021" cy="80.669" rx="17.979" ry="11.779"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="199.632" cy="80.493" rx="12.985" ry="10.29"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="179.681" y="67.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="40.353" height="26.486"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="176.296" y1="85.37" x2="224.708" y2="76.764"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M211.915,103.097v4.809h-0.38c-0.123-0.923-0.344-1.658-0.66-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.44,1.159c0.424,0.513,1.433,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.66,1.604c0.476,0.373,0.842,0.812,1.098,1.318s0.385,1.036,0.385,1.589
                                                          c0,1.053-0.408,1.96-1.225,2.723c-0.818,0.762-1.869,1.143-3.154,1.143c-0.402,0-0.782-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.317-0.374c-0.666-0.216-1.089-0.323-1.267-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          s-0.172,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.418,1.745,0.719,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          c0.618,0.328,1.297,0.492,2.035,0.492c0.854,0,1.529-0.226,2.025-0.677c0.495-0.451,0.743-0.984,0.743-1.6
                                                          c0-0.342-0.095-0.687-0.282-1.036s-0.48-0.673-0.877-0.974c-0.266-0.205-0.994-0.641-2.184-1.307
                                                          c-1.189-0.667-2.035-1.198-2.537-1.595c-0.504-0.396-0.885-0.834-1.145-1.313s-0.389-1.005-0.389-1.579
                                                          c0-0.998,0.383-1.857,1.148-2.579c0.766-0.721,1.739-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543
                                                          c0.383,0.171,0.653,0.256,0.811,0.256c0.178,0,0.322-0.053,0.436-0.159s0.203-0.32,0.271-0.641H211.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M200.859,80.618l2.983,4.45c0.827,1.23,1.44,2.008,1.841,2.333
                                                          c0.4,0.325,0.907,0.504,1.522,0.539v0.379h-5.968v-0.379c0.396-0.007,0.69-0.048,0.882-0.123c0.144-0.062,0.261-0.155,0.354-0.282
                                                          c0.092-0.126,0.138-0.255,0.138-0.385c0-0.157-0.03-0.314-0.093-0.472c-0.047-0.116-0.235-0.417-0.563-0.902l-2.358-3.568
                                                          l-2.912,3.732c-0.308,0.396-0.492,0.661-0.554,0.795c-0.062,0.133-0.093,0.271-0.093,0.415c0,0.219,0.093,0.4,0.277,0.543
                                                          s0.537,0.226,1.057,0.246v0.379h-4.933v-0.379c0.349-0.034,0.649-0.106,0.902-0.215c0.424-0.178,0.827-0.417,1.21-0.718
                                                          s0.82-0.762,1.313-1.384l3.281-4.143l-2.738-4.009c-0.744-1.087-1.377-1.8-1.896-2.138c-0.52-0.339-1.117-0.518-1.795-0.539
                                                          v-0.379h6.43v0.379c-0.547,0.021-0.922,0.109-1.123,0.267s-0.303,0.332-0.303,0.523c0,0.253,0.164,0.622,0.492,1.107l2.133,3.189
                                                          l2.472-3.127c0.287-0.369,0.463-0.622,0.528-0.759c0.064-0.137,0.098-0.277,0.098-0.42s-0.041-0.27-0.123-0.379
                                                          c-0.104-0.144-0.232-0.244-0.391-0.303c-0.156-0.058-0.481-0.09-0.974-0.097v-0.379h4.933v0.379
                                                          c-0.391,0.021-0.708,0.082-0.954,0.185c-0.369,0.157-0.708,0.369-1.015,0.636c-0.309,0.267-0.742,0.759-1.303,1.477
                                                          L200.859,80.618z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M197.676,74.173v5.496h3.055c0.793,0,1.323-0.12,1.59-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.38v4.84h-0.38c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.604-0.564c-0.281-0.137-0.711-0.205-1.293-0.205h-3.055v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.357c0.787,0,1.357-0.055,1.713-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.857-1.063,1.303-1.917h0.41l-1.2,3.486h-10.716v-0.379h0.492
                                                          c0.328,0,0.64-0.079,0.934-0.236c0.219-0.109,0.367-0.273,0.445-0.492c0.079-0.219,0.119-0.667,0.119-1.343v-9.034
                                                          c0-0.882-0.09-1.425-0.268-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.716l0.153,3.045h-0.399
                                                          c-0.144-0.731-0.302-1.234-0.478-1.507c-0.174-0.273-0.432-0.482-0.773-0.625c-0.273-0.103-0.756-0.154-1.445-0.154H197.676z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M204.381,69.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C204.1,69.304,204.256,69.214,204.381,69.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M212.443,69.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C212.162,69.304,212.318,69.214,212.443,69.214z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="178.633" y1="78.676" x2="220.633" y2="78.426"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="178.633" y1="82.559" x2="220.633" y2="82.309"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==16}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="207.521" cy="110.307" rx="20.479" ry="13.417"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="207.632" cy="110.285" rx="13.985" ry="11.083"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="184.681" y="95.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="46.353" height="30.424"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="183.669" y1="116.412" x2="233.047" y2="105.646"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>

                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M217.915,139.097v4.809h-0.38c-0.123-0.923-0.344-1.658-0.66-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.44,1.159c0.424,0.513,1.433,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.66,1.604c0.476,0.373,0.842,0.812,1.098,1.318s0.385,1.036,0.385,1.589
                                                          c0,1.053-0.408,1.96-1.225,2.723c-0.818,0.762-1.869,1.143-3.154,1.143c-0.402,0-0.782-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.317-0.374c-0.666-0.216-1.089-0.323-1.267-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          s-0.172,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.418,1.745,0.719,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          c0.618,0.328,1.297,0.492,2.035,0.492c0.854,0,1.529-0.226,2.025-0.677c0.495-0.451,0.743-0.984,0.743-1.6
                                                          c0-0.342-0.095-0.687-0.282-1.036s-0.48-0.673-0.877-0.974c-0.266-0.205-0.994-0.641-2.184-1.307
                                                          c-1.189-0.667-2.035-1.198-2.537-1.595c-0.504-0.396-0.885-0.834-1.145-1.313s-0.389-1.005-0.389-1.579
                                                          c0-0.998,0.383-1.857,1.148-2.579c0.766-0.721,1.739-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543
                                                          c0.383,0.171,0.653,0.256,0.811,0.256c0.178,0,0.322-0.053,0.436-0.159s0.203-0.32,0.271-0.641H217.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M206.676,104.173v5.496h3.055c0.793,0,1.323-0.12,1.59-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.38v4.84h-0.38c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.604-0.564c-0.281-0.137-0.711-0.205-1.293-0.205h-3.055v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.357c0.787,0,1.357-0.055,1.713-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.857-1.063,1.303-1.917h0.41l-1.2,3.486h-10.716v-0.379h0.492
                                                          c0.328,0,0.64-0.079,0.934-0.236c0.219-0.109,0.367-0.273,0.445-0.492c0.079-0.219,0.119-0.667,0.119-1.343v-9.034
                                                          c0-0.882-0.09-1.425-0.268-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.716l0.153,3.045h-0.399
                                                          c-0.144-0.731-0.302-1.234-0.478-1.507c-0.174-0.273-0.432-0.482-0.773-0.625c-0.273-0.103-0.756-0.154-1.445-0.154H206.676z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M206.676,104.173v5.496h3.055c0.793,0,1.323-0.12,1.59-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.38v4.84h-0.38c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.604-0.564c-0.281-0.137-0.711-0.205-1.293-0.205h-3.055v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.357c0.787,0,1.357-0.055,1.713-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.857-1.063,1.303-1.917h0.41l-1.2,3.486h-10.716v-0.379h0.492
                                                          c0.328,0,0.64-0.079,0.934-0.236c0.219-0.109,0.367-0.273,0.445-0.492c0.079-0.219,0.119-0.667,0.119-1.343v-9.034
                                                          c0-0.882-0.09-1.425-0.268-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.716l0.153,3.045h-0.399
                                                          c-0.144-0.731-0.302-1.234-0.478-1.507c-0.174-0.273-0.432-0.482-0.773-0.625c-0.273-0.103-0.756-0.154-1.445-0.154H206.676z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M213.381,100.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C213.1,100.304,213.256,100.214,213.381,100.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M221.443,100.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C221.162,100.304,221.318,100.214,221.443,100.214z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">

                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="186.632" y1="108.468" x2="228.632" y2="108.218"/>

                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="186.632" y1="112.351" x2="228.632" y2="112.101"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==17}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="215.521" cy="146.307" rx="20.479" ry="13.417"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="214.632" cy="146.078" rx="14.985" ry="11.875"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="192.681" y="131.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="46.353" height="30.424"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="190.354" y1="146.716" x2="239.033" y2="144.908"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M219.915,173.097v4.809h-0.38c-0.123-0.923-0.344-1.658-0.66-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.44,1.159c0.424,0.513,1.433,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.66,1.604c0.476,0.373,0.842,0.812,1.098,1.318s0.385,1.036,0.385,1.589
                                                          c0,1.053-0.408,1.96-1.225,2.723c-0.818,0.762-1.869,1.143-3.154,1.143c-0.402,0-0.782-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.317-0.374c-0.666-0.216-1.089-0.323-1.267-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          s-0.172,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.418,1.745,0.719,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          c0.618,0.328,1.297,0.492,2.035,0.492c0.854,0,1.529-0.226,2.025-0.677c0.495-0.451,0.743-0.984,0.743-1.6
                                                          c0-0.342-0.095-0.687-0.282-1.036s-0.48-0.673-0.877-0.974c-0.266-0.205-0.994-0.641-2.184-1.307
                                                          c-1.189-0.667-2.035-1.198-2.537-1.595c-0.504-0.396-0.885-0.834-1.145-1.313s-0.389-1.005-0.389-1.579
                                                          c0-0.998,0.383-1.857,1.148-2.579c0.766-0.721,1.739-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543
                                                          c0.383,0.171,0.653,0.256,0.811,0.256c0.178,0,0.322-0.053,0.436-0.159s0.203-0.32,0.271-0.641H219.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M215.859,146.618l2.983,4.45c0.827,1.23,1.44,2.008,1.841,2.333
                                                          c0.4,0.325,0.907,0.504,1.522,0.539v0.379h-5.968v-0.379c0.396-0.007,0.69-0.048,0.882-0.123c0.144-0.062,0.261-0.155,0.354-0.282
                                                          c0.092-0.126,0.138-0.255,0.138-0.385c0-0.157-0.03-0.314-0.093-0.472c-0.047-0.116-0.235-0.417-0.563-0.902l-2.358-3.568
                                                          l-2.912,3.732c-0.308,0.396-0.492,0.661-0.554,0.795c-0.062,0.133-0.093,0.271-0.093,0.415c0,0.219,0.093,0.4,0.277,0.543
                                                          s0.537,0.226,1.057,0.246v0.379h-4.933v-0.379c0.349-0.034,0.649-0.106,0.902-0.215c0.424-0.178,0.827-0.417,1.21-0.718
                                                          s0.82-0.762,1.313-1.384l3.281-4.143l-2.738-4.009c-0.744-1.087-1.377-1.8-1.896-2.138c-0.52-0.339-1.117-0.518-1.795-0.539
                                                          v-0.379h6.43v0.379c-0.547,0.021-0.922,0.109-1.123,0.267s-0.303,0.332-0.303,0.523c0,0.253,0.164,0.622,0.492,1.107l2.133,3.189
                                                          l2.472-3.127c0.287-0.369,0.463-0.622,0.528-0.759c0.064-0.137,0.098-0.277,0.098-0.42s-0.041-0.27-0.123-0.379
                                                          c-0.104-0.144-0.232-0.244-0.391-0.303c-0.156-0.058-0.481-0.09-0.974-0.097v-0.379h4.933v0.379
                                                          c-0.391,0.021-0.708,0.082-0.954,0.185c-0.369,0.157-0.708,0.369-1.015,0.636c-0.309,0.267-0.742,0.759-1.303,1.477
                                                          L215.859,146.618z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M212.676,140.173v5.496h3.055c0.793,0,1.323-0.12,1.59-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.38v4.84h-0.38c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.604-0.564c-0.281-0.137-0.711-0.205-1.293-0.205h-3.055v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.357c0.787,0,1.357-0.055,1.713-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.857-1.063,1.303-1.917h0.41l-1.2,3.486h-10.716v-0.379h0.492
                                                          c0.328,0,0.64-0.079,0.934-0.236c0.219-0.109,0.367-0.273,0.445-0.492c0.079-0.219,0.119-0.667,0.119-1.343v-9.034
                                                          c0-0.882-0.09-1.425-0.268-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.716l0.153,3.045h-0.399
                                                          c-0.144-0.731-0.302-1.234-0.478-1.507c-0.174-0.273-0.432-0.482-0.773-0.625c-0.273-0.103-0.756-0.154-1.445-0.154H212.676z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M220.381,136.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C220.1,136.304,220.256,136.214,220.381,136.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M228.443,136.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C228.162,136.304,228.318,136.214,228.443,136.214z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>

                                                    <g class="protesis">

                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="193.332" y1="144.261" x2="235.332" y2="144.011"/>

                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="193.332" y1="148.144" x2="235.332" y2="147.894"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==18}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="217.521" cy="180.307" rx="20.479" ry="13.417"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="215.632" cy="180.078" rx="14.985" ry="11.875"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="194.681" y="165.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="46.353" height="30.424"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="192.681" y1="183.206" x2="241.033" y2="180.716"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M75.915,49.696v4.306h-0.379c-0.123-0.826-0.344-1.484-0.662-1.974
                                                          s-0.771-0.878-1.358-1.166c-0.588-0.288-1.196-0.432-1.825-0.432c-0.711,0-1.299,0.195-1.764,0.583
                                                          c-0.465,0.389-0.697,0.831-0.697,1.327c0,0.379,0.147,0.725,0.441,1.037c0.424,0.459,1.432,1.071,3.025,1.836
                                                          c1.299,0.624,2.186,1.103,2.661,1.437c0.475,0.333,0.841,0.727,1.097,1.18s0.385,0.927,0.385,1.423
                                                          c0,0.943-0.409,1.755-1.226,2.438c-0.817,0.683-1.868,1.024-3.153,1.024c-0.403,0-0.783-0.028-1.138-0.083
                                                          c-0.212-0.031-0.651-0.143-1.318-0.335s-1.088-0.289-1.266-0.289c-0.171,0-0.306,0.046-0.405,0.138s-0.172,0.282-0.22,0.569
                                                          h-0.379v-4.27h0.379c0.178,0.894,0.417,1.563,0.718,2.006s0.76,0.813,1.379,1.106c0.619,0.293,1.297,0.44,2.036,0.44
                                                          c0.854,0,1.529-0.202,2.025-0.606c0.496-0.404,0.744-0.881,0.744-1.432c0-0.306-0.094-0.615-0.282-0.927s-0.48-0.603-0.876-0.872
                                                          c-0.267-0.184-0.995-0.574-2.184-1.171s-2.036-1.072-2.538-1.428c-0.502-0.354-0.883-0.747-1.143-1.175
                                                          c-0.26-0.429-0.39-0.9-0.39-1.414c0-0.894,0.383-1.663,1.148-2.309c0.766-0.646,1.74-0.969,2.922-0.969
                                                          c0.738,0,1.521,0.163,2.348,0.487c0.383,0.153,0.653,0.229,0.81,0.229c0.178,0,0.323-0.047,0.436-0.143
                                                          c0.113-0.095,0.204-0.286,0.272-0.574H75.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M217.859,180.618l2.983,4.45c0.827,1.23,1.44,2.008,1.841,2.333
                                                          c0.4,0.325,0.907,0.504,1.522,0.539v0.379h-5.968v-0.379c0.396-0.007,0.69-0.048,0.882-0.123c0.144-0.062,0.261-0.155,0.354-0.282
                                                          c0.092-0.126,0.138-0.255,0.138-0.385c0-0.157-0.03-0.314-0.093-0.472c-0.047-0.116-0.235-0.417-0.563-0.902l-2.358-3.568
                                                          l-2.912,3.732c-0.308,0.396-0.492,0.661-0.554,0.795c-0.062,0.133-0.093,0.271-0.093,0.415c0,0.219,0.093,0.4,0.277,0.543
                                                          s0.537,0.226,1.057,0.246v0.379h-4.933v-0.379c0.349-0.034,0.649-0.106,0.902-0.215c0.424-0.178,0.827-0.417,1.21-0.718
                                                          s0.82-0.762,1.313-1.384l3.281-4.143l-2.738-4.009c-0.744-1.087-1.377-1.8-1.896-2.138c-0.52-0.339-1.117-0.518-1.795-0.539
                                                          v-0.379h6.43v0.379c-0.547,0.021-0.922,0.109-1.123,0.267s-0.303,0.332-0.303,0.523c0,0.253,0.164,0.622,0.492,1.107l2.133,3.189
                                                          l2.472-3.127c0.287-0.369,0.463-0.622,0.528-0.759c0.064-0.137,0.098-0.277,0.098-0.42s-0.041-0.27-0.123-0.379
                                                          c-0.104-0.144-0.232-0.244-0.391-0.303c-0.156-0.058-0.481-0.09-0.974-0.097v-0.379h4.933v0.379
                                                          c-0.391,0.021-0.708,0.082-0.954,0.185c-0.369,0.157-0.708,0.369-1.015,0.636c-0.309,0.267-0.742,0.759-1.303,1.477
                                                          L217.859,180.618z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M214.676,174.173v5.496h3.055c0.793,0,1.323-0.12,1.59-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.38v4.84h-0.38c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.604-0.564c-0.281-0.137-0.711-0.205-1.293-0.205h-3.055v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.357c0.787,0,1.357-0.055,1.713-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.857-1.063,1.303-1.917h0.41l-1.2,3.486h-10.716v-0.379h0.492
                                                          c0.328,0,0.64-0.079,0.934-0.236c0.219-0.109,0.367-0.273,0.445-0.492c0.079-0.219,0.119-0.667,0.119-1.343v-9.034
                                                          c0-0.882-0.09-1.425-0.268-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.716l0.153,3.045h-0.399
                                                          c-0.144-0.731-0.302-1.234-0.478-1.507c-0.174-0.273-0.432-0.482-0.773-0.625c-0.273-0.103-0.756-0.154-1.445-0.154H214.676z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M222.381,168.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C222.1,168.304,222.256,168.214,222.381,168.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M230.443,168.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C230.162,168.304,230.318,168.214,230.443,168.214z"/>
                                                    </g>

                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">

                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="194.631" y1="178.444" x2="236.631" y2="178.194"/>

                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="194.631" y1="182.327" x2="236.631" y2="182.077"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==21}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse fill="transparent" class="caries" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="40.521" cy="302.687" rx="16.479" ry="10.797"/>

                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="118.515" cy="14.14" rx="6.485" ry="5.139"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="106.681" y="7.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="22.353" height="14.672"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="106.521" y1="14.248" x2="129.78" y2="14.248"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M120.411,10.841v2.061h-0.163c-0.053-0.396-0.147-0.71-0.283-0.945
                                                          s-0.33-0.42-0.582-0.558s-0.513-0.207-0.782-0.207c-0.304,0-0.556,0.093-0.755,0.279c-0.199,0.187-0.299,0.398-0.299,0.635
                                                          c0,0.182,0.063,0.347,0.188,0.497c0.182,0.22,0.614,0.513,1.296,0.879c0.557,0.299,0.937,0.528,1.14,0.688
                                                          c0.204,0.16,0.36,0.348,0.471,0.565c0.109,0.217,0.164,0.444,0.164,0.681c0,0.451-0.175,0.84-0.524,1.167s-0.8,0.49-1.351,0.49
                                                          c-0.173,0-0.336-0.013-0.487-0.04c-0.091-0.015-0.279-0.068-0.564-0.16c-0.286-0.093-0.467-0.139-0.543-0.139
                                                          c-0.073,0-0.131,0.022-0.174,0.066c-0.042,0.044-0.073,0.135-0.094,0.272h-0.163v-2.043h0.163c0.076,0.428,0.179,0.748,0.307,0.96
                                                          c0.129,0.213,0.326,0.389,0.591,0.53c0.266,0.141,0.556,0.211,0.872,0.211c0.366,0,0.655-0.097,0.868-0.29
                                                          c0.212-0.193,0.318-0.422,0.318-0.686c0-0.146-0.04-0.294-0.121-0.444c-0.08-0.149-0.206-0.289-0.375-0.417
                                                          c-0.114-0.088-0.427-0.275-0.937-0.56c-0.509-0.286-0.871-0.514-1.087-0.684c-0.215-0.17-0.378-0.357-0.489-0.563
                                                          s-0.167-0.431-0.167-0.677c0-0.428,0.164-0.796,0.492-1.105c0.327-0.309,0.745-0.463,1.251-0.463c0.316,0,0.652,0.078,1.006,0.233
                                                          c0.164,0.073,0.28,0.11,0.348,0.11c0.076,0,0.138-0.022,0.187-0.068c0.048-0.045,0.087-0.137,0.116-0.275H120.411z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M118.958,14.636l1.278,1.907c0.354,0.527,0.617,0.861,0.789,1
                                                          c0.171,0.14,0.389,0.216,0.652,0.231v0.163h-2.557v-0.163c0.17-0.003,0.296-0.021,0.378-0.053
                                                          c0.062-0.026,0.111-0.066,0.151-0.121c0.039-0.054,0.059-0.109,0.059-0.165c0-0.067-0.013-0.135-0.039-0.202
                                                          c-0.021-0.05-0.101-0.179-0.241-0.387l-1.011-1.529l-1.247,1.6c-0.132,0.17-0.211,0.283-0.237,0.341
                                                          c-0.026,0.057-0.04,0.116-0.04,0.178c0,0.094,0.04,0.171,0.119,0.233s0.229,0.097,0.452,0.105v0.163h-2.113v-0.163
                                                          c0.149-0.015,0.278-0.045,0.387-0.092c0.182-0.076,0.354-0.179,0.519-0.308s0.352-0.327,0.563-0.593l1.405-1.775l-1.173-1.718
                                                          c-0.319-0.466-0.59-0.771-0.813-0.916c-0.223-0.146-0.479-0.222-0.769-0.231v-0.163h2.754v0.163
                                                          c-0.234,0.009-0.395,0.047-0.48,0.114c-0.087,0.067-0.13,0.142-0.13,0.224c0,0.108,0.07,0.267,0.211,0.475l0.913,1.367l1.059-1.34
                                                          c0.123-0.158,0.199-0.267,0.227-0.325c0.028-0.059,0.042-0.119,0.042-0.18s-0.018-0.116-0.053-0.163
                                                          c-0.044-0.062-0.1-0.104-0.167-0.13c-0.067-0.024-0.207-0.039-0.417-0.042v-0.163h2.112v0.163
                                                          c-0.167,0.009-0.303,0.035-0.408,0.079c-0.158,0.067-0.304,0.158-0.435,0.272c-0.132,0.114-0.318,0.325-0.559,0.633
                                                          L118.958,14.636z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M118.166,11.303v2.355h1.31c0.339,0,0.566-0.051,0.681-0.154
                                                          c0.152-0.135,0.237-0.372,0.255-0.712h0.162v2.074h-0.162c-0.041-0.29-0.082-0.476-0.123-0.558
                                                          c-0.053-0.103-0.14-0.183-0.26-0.242s-0.305-0.088-0.553-0.088h-1.31v1.964c0,0.264,0.012,0.424,0.035,0.481
                                                          c0.023,0.057,0.064,0.103,0.123,0.136c0.059,0.034,0.17,0.051,0.334,0.051h1.01c0.337,0,0.582-0.023,0.734-0.07
                                                          c0.151-0.047,0.298-0.139,0.438-0.277c0.182-0.182,0.368-0.456,0.559-0.822h0.176l-0.515,1.494h-4.59v-0.163h0.211
                                                          c0.141,0,0.273-0.034,0.399-0.101c0.094-0.047,0.157-0.117,0.191-0.211c0.033-0.094,0.051-0.286,0.051-0.576v-3.872
                                                          c0-0.378-0.038-0.611-0.114-0.699c-0.105-0.117-0.281-0.176-0.527-0.176h-0.211v-0.163h4.59l0.066,1.305h-0.172
                                                          c-0.062-0.313-0.129-0.529-0.204-0.646c-0.074-0.117-0.185-0.207-0.331-0.268c-0.117-0.044-0.324-0.066-0.62-0.066H118.166z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M118.367,5.201c0.084-0.057,0.19-0.068,0.318-0.032
                                                          c0.101,0.036,0.177,0.093,0.229,0.17c0.1,0.149,0.121,0.417,0.063,0.806c-0.011,0.178-0.024,0.338-0.041,0.48
                                                          c-0.017,0.144-0.056,0.448-0.116,0.915c-0.215,1.495-0.471,4.536-0.766,9.125c-0.199,3.021-0.342,5.52-0.428,7.494
                                                          c-0.035,1.939-0.074,3.844-0.119,5.714l-0.039,2.22c0.002,0.811,0.009,1.273,0.02,1.388c0.021,0.308-0.047,0.514-0.203,0.619
                                                          c-0.207,0.14-0.371,0.12-0.494-0.061c-0.145-0.213-0.22-0.861-0.226-1.942c-0.03-3.358,0.128-7.923,0.472-13.695
                                                          c0.386-6.31,0.693-10.198,0.926-11.667c0.096-0.583,0.15-0.933,0.168-1.047C118.186,5.433,118.263,5.271,118.367,5.201z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M125.039,0.682c0.084-0.057,0.19-0.067,0.318-0.032
                                                          c0.101,0.036,0.177,0.093,0.229,0.17c0.1,0.149,0.121,0.417,0.063,0.806c-0.011,0.178-0.024,0.338-0.041,0.481
                                                          s-0.056,0.448-0.116,0.915c-0.215,1.494-0.47,4.536-0.766,9.124c-0.199,3.022-0.342,5.52-0.428,7.494
                                                          c-0.035,1.939-0.074,3.844-0.119,5.714l-0.039,2.22c0.002,0.811,0.009,1.273,0.021,1.388c0.021,0.308-0.048,0.514-0.204,0.619
                                                          c-0.206,0.14-0.371,0.12-0.494-0.061c-0.145-0.213-0.219-0.861-0.225-1.942c-0.03-3.358,0.127-7.923,0.471-13.695
                                                          c0.386-6.31,0.693-10.198,0.926-11.667c0.096-0.583,0.15-0.933,0.168-1.048C124.858,0.913,124.935,0.752,125.039,0.682z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="107.667" y1="12.323" x2="129.793" y2="12.073"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="107.667" y1="16.206" x2="129.793" y2="15.956"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==22}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="101.521" cy="23.755" rx="10.479" ry="6.866"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="102.015" cy="23.536" rx="6.985" ry="5.535"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="88.681" y="15.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="25.353" height="16.641"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>

                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="85.857" y1="23.824" x2="114.033" y2="23.824"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M103.869,20.164v2.29h-0.181c-0.059-0.439-0.163-0.79-0.314-1.05
                                                          s-0.367-0.467-0.647-0.62c-0.279-0.153-0.569-0.229-0.868-0.229c-0.339,0-0.618,0.104-0.84,0.31
                                                          c-0.221,0.207-0.332,0.442-0.332,0.706c0,0.202,0.07,0.386,0.21,0.552c0.202,0.244,0.682,0.57,1.44,0.977
                                                          c0.618,0.332,1.04,0.587,1.267,0.764c0.226,0.177,0.399,0.387,0.521,0.627s0.184,0.493,0.184,0.757
                                                          c0,0.501-0.194,0.934-0.584,1.296c-0.389,0.363-0.889,0.544-1.5,0.544c-0.192,0-0.373-0.015-0.542-0.044
                                                          c-0.101-0.016-0.31-0.076-0.627-0.178s-0.519-0.154-0.604-0.154c-0.081,0-0.146,0.024-0.192,0.073s-0.082,0.15-0.104,0.303h-0.181
                                                          v-2.271h0.181c0.084,0.475,0.198,0.831,0.341,1.067c0.144,0.236,0.362,0.432,0.657,0.588c0.294,0.156,0.617,0.234,0.969,0.234
                                                          c0.406,0,0.728-0.107,0.964-0.322c0.235-0.215,0.354-0.469,0.354-0.762c0-0.163-0.045-0.327-0.134-0.493
                                                          c-0.09-0.166-0.229-0.321-0.418-0.464c-0.127-0.098-0.473-0.305-1.039-0.623s-0.969-0.57-1.208-0.759s-0.421-0.397-0.544-0.625
                                                          c-0.124-0.228-0.186-0.479-0.186-0.752c0-0.475,0.182-0.885,0.546-1.228c0.365-0.343,0.828-0.515,1.392-0.515
                                                          c0.352,0,0.724,0.086,1.117,0.259c0.183,0.082,0.311,0.122,0.386,0.122c0.085,0,0.154-0.025,0.208-0.076s0.097-0.152,0.129-0.305
                                                          H103.869z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M102.366,24.27l1.42,2.119c0.395,0.586,0.687,0.956,0.877,1.111
                                                          c0.189,0.155,0.432,0.24,0.725,0.256v0.181h-2.841v-0.181c0.188-0.003,0.329-0.023,0.42-0.059
                                                          c0.068-0.029,0.124-0.074,0.168-0.134s0.066-0.121,0.066-0.183c0-0.075-0.015-0.15-0.044-0.225
                                                          c-0.023-0.055-0.112-0.199-0.269-0.43l-1.123-1.699l-1.386,1.777c-0.146,0.189-0.234,0.315-0.264,0.378s-0.044,0.129-0.044,0.198
                                                          c0,0.104,0.044,0.19,0.132,0.259s0.256,0.107,0.503,0.117v0.181h-2.348v-0.181c0.166-0.016,0.309-0.05,0.43-0.103
                                                          c0.201-0.084,0.394-0.199,0.576-0.342c0.182-0.143,0.39-0.363,0.624-0.659l1.562-1.973l-1.303-1.909
                                                          c-0.354-0.518-0.655-0.857-0.902-1.018c-0.248-0.161-0.532-0.247-0.854-0.256v-0.181h3.06v0.181
                                                          c-0.26,0.01-0.438,0.052-0.534,0.127s-0.144,0.158-0.144,0.249c0,0.121,0.078,0.296,0.234,0.527l1.015,1.519l1.177-1.489
                                                          c0.137-0.176,0.22-0.296,0.251-0.361s0.047-0.132,0.047-0.2s-0.02-0.128-0.059-0.181c-0.049-0.068-0.111-0.116-0.186-0.144
                                                          c-0.075-0.028-0.229-0.043-0.464-0.046v-0.181h2.348v0.181c-0.186,0.01-0.337,0.039-0.454,0.088
                                                          c-0.176,0.075-0.337,0.176-0.483,0.303s-0.353,0.361-0.619,0.703L102.366,24.27z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M101.375,20.677v2.617h1.454c0.378,0,0.63-0.057,0.757-0.171
                                                          c0.169-0.15,0.264-0.414,0.283-0.791h0.181v2.305h-0.181c-0.046-0.322-0.091-0.529-0.137-0.62
                                                          c-0.059-0.114-0.154-0.204-0.288-0.269s-0.338-0.098-0.615-0.098h-1.454v2.183c0,0.293,0.013,0.471,0.039,0.535
                                                          s0.071,0.114,0.137,0.151s0.188,0.056,0.371,0.056h1.122c0.374,0,0.646-0.026,0.815-0.078s0.332-0.155,0.488-0.308
                                                          c0.201-0.202,0.408-0.506,0.619-0.913h0.195l-0.57,1.66h-5.101v-0.181h0.234c0.156,0,0.304-0.038,0.444-0.112
                                                          c0.104-0.052,0.175-0.13,0.212-0.234s0.056-0.317,0.056-0.64v-4.302c0-0.42-0.042-0.679-0.126-0.776
                                                          c-0.117-0.13-0.313-0.195-0.586-0.195h-0.234v-0.181h5.101l0.073,1.45h-0.19c-0.068-0.348-0.145-0.587-0.228-0.718
                                                          s-0.206-0.229-0.368-0.298c-0.13-0.049-0.359-0.073-0.688-0.073H101.375z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M99.21,13.611c0.066-0.088,0.165-0.142,0.295-0.161
                                                          c0.104-0.007,0.191,0.016,0.259,0.067c0.133,0.1,0.218,0.344,0.258,0.734c0.032,0.174,0.059,0.331,0.077,0.473
                                                          c0.02,0.142,0.056,0.446,0.111,0.912c0.159,1.5,0.655,4.48,1.488,8.94c0.546,2.938,1.019,5.359,1.416,7.261
                                                          c0.438,1.848,0.863,3.665,1.276,5.451l0.503,2.114c0.2,0.766,0.318,1.2,0.357,1.303c0.093,0.282,0.079,0.505-0.043,0.669
                                                          c-0.164,0.218-0.326,0.266-0.487,0.146c-0.189-0.143-0.418-0.723-0.688-1.743c-0.845-3.161-1.805-7.541-2.881-13.14
                                                          c-1.167-6.123-1.819-9.927-1.956-11.41c-0.05-0.59-0.082-0.944-0.094-1.06C99.092,13.905,99.128,13.721,99.21,13.611z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M104.472,6.592c0.066-0.088,0.165-0.143,0.295-0.162
                                                          c0.104-0.007,0.191,0.016,0.259,0.067c0.133,0.1,0.218,0.344,0.258,0.735c0.032,0.173,0.059,0.331,0.077,0.473
                                                          c0.02,0.142,0.056,0.446,0.111,0.912c0.159,1.5,0.655,4.48,1.489,8.94c0.546,2.938,1.018,5.358,1.415,7.261
                                                          c0.438,1.848,0.863,3.664,1.276,5.45l0.503,2.114c0.2,0.766,0.318,1.2,0.357,1.303c0.093,0.283,0.079,0.505-0.043,0.669
                                                          c-0.163,0.217-0.326,0.266-0.487,0.146c-0.189-0.143-0.418-0.724-0.688-1.743c-0.845-3.162-1.805-7.542-2.88-13.14
                                                          c-1.168-6.123-1.819-9.926-1.956-11.41c-0.05-0.59-0.082-0.944-0.094-1.059C104.354,6.885,104.391,6.701,104.472,6.592z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="145.379" y1="20.719" x2="171.793" y2="20.469"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="145.379" y1="24.602" x2="171.793" y2="24.352"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==23}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="86.021" cy="37.394" rx="12.979" ry="8.503"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="85.633" cy="37.322" rx="8.985" ry="7.121"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="70.681" y="26.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="30.353" height="19.923"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="67.151" y1="35.145" x2="101.293" y2="37.27"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M88.492,32.288v3.601h-0.284c-0.092-0.691-0.257-1.241-0.495-1.65
                                                          c-0.237-0.41-0.577-0.734-1.017-0.975c-0.44-0.241-0.896-0.361-1.366-0.361c-0.532,0-0.972,0.163-1.319,0.487
                                                          c-0.349,0.325-0.522,0.695-0.522,1.109c0,0.317,0.11,0.606,0.33,0.868c0.317,0.384,1.072,0.896,2.264,1.536
                                                          c0.973,0.522,1.636,0.922,1.991,1.201c0.355,0.279,0.63,0.608,0.821,0.987c0.192,0.379,0.288,0.775,0.288,1.19
                                                          c0,0.788-0.306,1.468-0.917,2.038c-0.611,0.571-1.398,0.856-2.359,0.856c-0.303,0-0.586-0.023-0.853-0.069
                                                          c-0.158-0.026-0.487-0.119-0.985-0.28c-0.499-0.161-0.815-0.242-0.948-0.242c-0.128,0-0.229,0.038-0.303,0.115
                                                          c-0.074,0.077-0.13,0.235-0.165,0.476h-0.284v-3.57h0.284c0.133,0.748,0.312,1.307,0.537,1.678
                                                          c0.225,0.371,0.569,0.679,1.032,0.925s0.971,0.369,1.523,0.369c0.639,0,1.145-0.169,1.515-0.507
                                                          c0.371-0.338,0.557-0.737,0.557-1.198c0-0.256-0.07-0.514-0.211-0.775c-0.141-0.261-0.359-0.504-0.656-0.729
                                                          c-0.199-0.154-0.744-0.48-1.635-0.979c-0.89-0.499-1.522-0.897-1.898-1.194s-0.662-0.625-0.856-0.982
                                                          c-0.194-0.358-0.291-0.752-0.291-1.183c0-0.747,0.286-1.391,0.859-1.931s1.302-0.81,2.187-0.81c0.553,0,1.139,0.136,1.758,0.407
                                                          c0.286,0.128,0.488,0.192,0.606,0.192c0.133,0,0.241-0.04,0.326-0.119c0.084-0.08,0.152-0.239,0.203-0.48H88.492z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M86.701,38.171l2.233,3.332c0.619,0.921,1.078,1.503,1.378,1.747
                                                          c0.299,0.243,0.679,0.377,1.139,0.403v0.284h-4.466v-0.284c0.297-0.005,0.517-0.036,0.66-0.092
                                                          c0.107-0.046,0.195-0.117,0.265-0.211s0.104-0.19,0.104-0.288c0-0.118-0.023-0.235-0.069-0.354
                                                          c-0.035-0.087-0.176-0.312-0.422-0.675l-1.765-2.672l-2.18,2.794c-0.23,0.297-0.368,0.495-0.414,0.595
                                                          c-0.046,0.1-0.069,0.203-0.069,0.311c0,0.164,0.069,0.299,0.207,0.407c0.139,0.107,0.401,0.169,0.791,0.184v0.284h-3.691v-0.284
                                                          c0.261-0.025,0.486-0.079,0.675-0.161c0.317-0.133,0.619-0.312,0.906-0.538c0.286-0.225,0.613-0.57,0.981-1.036l2.456-3.102
                                                          l-2.049-3.002c-0.558-0.814-1.031-1.348-1.42-1.601c-0.389-0.253-0.836-0.388-1.343-0.403v-0.284h4.812v0.284
                                                          c-0.409,0.016-0.689,0.082-0.84,0.2c-0.151,0.118-0.227,0.248-0.227,0.392c0,0.189,0.122,0.466,0.368,0.829l1.596,2.388
                                                          l1.85-2.342c0.215-0.276,0.347-0.465,0.396-0.568s0.073-0.208,0.073-0.315s-0.031-0.202-0.093-0.284
                                                          c-0.076-0.107-0.174-0.183-0.291-0.226c-0.118-0.043-0.361-0.068-0.729-0.073v-0.284h3.691v0.284
                                                          c-0.292,0.016-0.529,0.062-0.714,0.138c-0.276,0.118-0.529,0.276-0.76,0.476s-0.555,0.568-0.975,1.105L86.701,38.171z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M84.57,33.094v4.115h2.287c0.594,0,0.99-0.09,1.189-0.269
                                                          c0.266-0.235,0.414-0.65,0.445-1.244h0.283v3.624h-0.283c-0.072-0.506-0.144-0.832-0.215-0.975
                                                          c-0.093-0.179-0.243-0.32-0.453-0.422s-0.532-0.154-0.967-0.154H84.57v3.432c0,0.46,0.021,0.741,0.062,0.84
                                                          c0.041,0.1,0.112,0.179,0.215,0.238c0.103,0.059,0.297,0.088,0.583,0.088h1.766c0.588,0,1.016-0.041,1.281-0.123
                                                          s0.521-0.243,0.768-0.484c0.317-0.317,0.642-0.795,0.975-1.436h0.307l-0.897,2.61h-8.02v-0.284h0.368
                                                          c0.246,0,0.479-0.059,0.698-0.176c0.164-0.082,0.275-0.205,0.334-0.369s0.088-0.499,0.088-1.006v-6.764
                                                          c0-0.66-0.066-1.067-0.199-1.221c-0.184-0.205-0.491-0.307-0.921-0.307h-0.368v-0.284h8.02l0.115,2.28h-0.3
                                                          c-0.107-0.547-0.227-0.924-0.356-1.128c-0.131-0.205-0.324-0.361-0.58-0.468c-0.204-0.077-0.564-0.115-1.082-0.115H84.57z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M84.267,26.85c0.072-0.071,0.174-0.101,0.307-0.089
                                                          c0.105,0.017,0.19,0.059,0.256,0.125c0.127,0.128,0.197,0.388,0.211,0.78c0.021,0.177,0.037,0.336,0.047,0.48
                                                          c0.01,0.144,0.027,0.45,0.053,0.92c0.062,1.508,0.365,4.545,0.912,9.11c0.355,3.008,0.672,5.49,0.947,7.446
                                                          c0.319,1.914,0.629,3.793,0.926,5.64l0.367,2.189c0.15,0.796,0.24,1.25,0.273,1.361c0.075,0.299,0.047,0.514-0.087,0.646
                                                          c-0.179,0.175-0.345,0.186-0.498,0.03c-0.181-0.184-0.372-0.806-0.576-1.868c-0.642-3.296-1.321-7.813-2.036-13.551
                                                          c-0.771-6.274-1.179-10.153-1.219-11.64c-0.014-0.592-0.021-0.945-0.026-1.062C84.13,27.11,84.177,26.938,84.267,26.85z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M90.001,21.188c0.072-0.071,0.176-0.101,0.308-0.089
                                                          c0.104,0.018,0.19,0.06,0.257,0.126c0.125,0.128,0.195,0.388,0.209,0.78c0.021,0.177,0.038,0.336,0.048,0.48
                                                          c0.011,0.144,0.028,0.45,0.052,0.92c0.063,1.509,0.367,4.546,0.913,9.111c0.356,3.008,0.673,5.49,0.948,7.446
                                                          c0.318,1.914,0.627,3.793,0.924,5.641l0.368,2.189c0.149,0.796,0.241,1.25,0.272,1.361c0.076,0.299,0.047,0.514-0.086,0.646
                                                          c-0.178,0.175-0.344,0.186-0.498,0.03c-0.181-0.184-0.373-0.806-0.576-1.868c-0.643-3.296-1.32-7.813-2.036-13.551
                                                          c-0.772-6.274-1.179-10.153-1.22-11.64c-0.012-0.591-0.021-0.945-0.025-1.061C89.865,21.449,89.913,21.276,90.001,21.188z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="68.588" y1="35.506" x2="102.677" y2="35.256"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="68.588" y1="39.389" x2="102.677" y2="39.139"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==24}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="72.021" cy="56.359" rx="15.979" ry="10.469"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="72.132" cy="56.303" rx="11.485" ry="9.102"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="57.622" y1="54.564" x2="88.681" y2="56.106"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="57.622" y1="54.564" x2="88.681" y2="56.106"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M60.915,73.097v4.809h-0.379c-0.123-0.923-0.344-1.658-0.661-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.441,1.159c0.424,0.513,1.432,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.661,1.604c0.475,0.373,0.841,0.812,1.098,1.318c0.256,0.506,0.384,1.036,0.384,1.589
                                                          c0,1.053-0.409,1.96-1.225,2.723c-0.817,0.762-1.868,1.143-3.153,1.143c-0.403,0-0.783-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.318-0.374c-0.666-0.216-1.088-0.323-1.266-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          c-0.1,0.103-0.173,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.417,1.745,0.718,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          s1.297,0.492,2.036,0.492c0.854,0,1.529-0.226,2.025-0.677s0.744-0.984,0.744-1.6c0-0.342-0.094-0.687-0.282-1.036
                                                          c-0.188-0.349-0.48-0.673-0.877-0.974c-0.267-0.205-0.995-0.641-2.184-1.307c-1.189-0.667-2.036-1.198-2.538-1.595
                                                          c-0.503-0.396-0.884-0.834-1.144-1.313s-0.39-1.005-0.39-1.579c0-0.998,0.383-1.857,1.148-2.579
                                                          c0.766-0.721,1.74-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543c0.383,0.171,0.653,0.256,0.81,0.256
                                                          c0.178,0,0.323-0.053,0.436-0.159c0.112-0.106,0.203-0.32,0.271-0.641H60.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M73.859,56.536l2.984,3.984c0.827,1.102,1.44,1.798,1.84,2.089
                                                          c0.4,0.291,0.908,0.452,1.523,0.482v0.34h-5.968v-0.34c0.396-0.006,0.69-0.042,0.882-0.11c0.144-0.055,0.261-0.139,0.354-0.252
                                                          s0.139-0.228,0.139-0.345c0-0.141-0.031-0.281-0.092-0.422c-0.048-0.104-0.236-0.374-0.564-0.808l-2.358-3.195l-2.912,3.342
                                                          c-0.308,0.355-0.492,0.592-0.554,0.711c-0.062,0.119-0.092,0.243-0.092,0.372c0,0.196,0.092,0.358,0.277,0.487
                                                          s0.537,0.202,1.056,0.22v0.34H65.44v-0.34c0.349-0.03,0.649-0.095,0.902-0.193c0.424-0.159,0.827-0.373,1.21-0.643
                                                          c0.383-0.269,0.82-0.682,1.313-1.239l3.281-3.709l-2.738-3.59c-0.745-0.973-1.377-1.611-1.897-1.914s-1.118-0.464-1.794-0.482
                                                          v-0.34h6.429v0.34c-0.547,0.018-0.921,0.098-1.123,0.239s-0.302,0.297-0.302,0.468c0,0.227,0.164,0.557,0.492,0.991l2.133,2.855
                                                          l2.471-2.8c0.287-0.331,0.463-0.557,0.528-0.679s0.098-0.248,0.098-0.376s-0.041-0.242-0.123-0.34
                                                          c-0.103-0.128-0.232-0.219-0.39-0.271c-0.157-0.052-0.482-0.081-0.974-0.087v-0.34h4.932v0.34
                                                          c-0.39,0.018-0.708,0.073-0.954,0.165c-0.369,0.141-0.708,0.331-1.015,0.569s-0.742,0.68-1.302,1.322L73.859,56.536z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M70.675,50.661v4.921h3.056c0.793,0,1.323-0.107,1.589-0.321
                                                          c0.355-0.282,0.554-0.777,0.595-1.487h0.379v4.333h-0.379c-0.096-0.606-0.191-0.995-0.287-1.166
                                                          c-0.123-0.214-0.325-0.382-0.605-0.505s-0.711-0.184-1.292-0.184h-3.056v4.104c0,0.551,0.027,0.886,0.082,1.005
                                                          c0.055,0.12,0.15,0.214,0.287,0.285c0.137,0.071,0.396,0.106,0.779,0.106h2.358c0.786,0,1.357-0.049,1.712-0.147
                                                          c0.355-0.098,0.697-0.291,1.025-0.579c0.424-0.379,0.858-0.952,1.302-1.717h0.41l-1.2,3.122H66.717v-0.34h0.492
                                                          c0.328,0,0.639-0.07,0.933-0.211c0.219-0.098,0.367-0.245,0.446-0.441c0.079-0.196,0.118-0.597,0.118-1.203v-8.088
                                                          c0-0.79-0.089-1.276-0.267-1.46c-0.246-0.245-0.656-0.367-1.23-0.367h-0.492v-0.34h10.715l0.154,2.727h-0.4
                                                          c-0.144-0.655-0.303-1.105-0.477-1.35c-0.174-0.245-0.432-0.432-0.774-0.56c-0.273-0.092-0.755-0.138-1.446-0.138H70.675z"/>
                                                    </g>

                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M74.122,45.707c0.111-0.017,0.223,0.019,0.332,0.105
                                                          c0.082,0.075,0.13,0.159,0.144,0.251c0.026,0.178-0.087,0.431-0.338,0.76c-0.101,0.157-0.194,0.297-0.282,0.421
                                                          s-0.278,0.385-0.572,0.783c-0.96,1.271-2.733,3.933-5.32,7.985c-1.705,2.667-3.095,4.882-4.168,6.643
                                                          c-1.003,1.75-1.993,3.468-2.972,5.152l-1.147,2.005c-0.402,0.739-0.627,1.162-0.672,1.272c-0.134,0.288-0.305,0.447-0.512,0.478
                                                          c-0.276,0.041-0.43-0.047-0.462-0.263c-0.038-0.255,0.21-0.876,0.744-1.863c1.647-3.069,4.083-7.16,7.309-12.27
                                                          c3.534-5.582,5.784-8.993,6.748-10.232c0.386-0.492,0.616-0.786,0.69-0.883C73.824,45.841,73.983,45.727,74.122,45.707z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M83.03,44.395c0.112-0.016,0.223,0.019,0.332,0.105
                                                          c0.082,0.075,0.13,0.158,0.144,0.251c0.026,0.178-0.087,0.431-0.338,0.76c-0.101,0.157-0.194,0.297-0.282,0.421
                                                          c-0.087,0.124-0.278,0.385-0.572,0.783c-0.96,1.271-2.732,3.932-5.32,7.985c-1.705,2.667-3.095,4.882-4.167,6.643
                                                          c-1.004,1.75-1.994,3.468-2.973,5.152L68.707,68.5c-0.402,0.739-0.627,1.163-0.673,1.272c-0.134,0.288-0.305,0.448-0.512,0.478
                                                          c-0.276,0.041-0.43-0.047-0.462-0.263c-0.038-0.255,0.21-0.876,0.744-1.863c1.647-3.069,4.083-7.159,7.309-12.27
                                                          c3.534-5.582,5.784-8.993,6.748-10.233c0.386-0.491,0.616-0.785,0.69-0.883C82.732,44.53,82.892,44.416,83.03,44.395z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="52.941" y1="54.487" x2="91.324" y2="54.237"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="52.941" y1="58.37" x2="91.324" y2="58.12"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==25}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="58.021" cy="80.669" rx="17.979" ry="11.779"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="57.633" cy="80.493" rx="12.985" ry="10.29"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="37.681" y="66.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="40.353" height="26.486"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>

                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="39.455" y1="77.477" x2="75.789" y2="78.132"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M52.915,103.097v4.809h-0.379c-0.123-0.923-0.344-1.658-0.661-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.441,1.159c0.424,0.513,1.432,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.661,1.604c0.475,0.373,0.841,0.812,1.098,1.318c0.256,0.506,0.384,1.036,0.384,1.589
                                                          c0,1.053-0.409,1.96-1.225,2.723c-0.817,0.762-1.868,1.143-3.153,1.143c-0.403,0-0.783-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.318-0.374c-0.666-0.216-1.088-0.323-1.266-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          c-0.1,0.103-0.173,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.417,1.745,0.718,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          s1.297,0.492,2.036,0.492c0.854,0,1.529-0.226,2.025-0.677s0.744-0.984,0.744-1.6c0-0.342-0.094-0.687-0.282-1.036
                                                          c-0.188-0.349-0.48-0.673-0.877-0.974c-0.267-0.205-0.995-0.641-2.184-1.307c-1.189-0.667-2.036-1.198-2.538-1.595
                                                          c-0.503-0.396-0.884-0.834-1.144-1.313s-0.39-1.005-0.39-1.579c0-0.998,0.383-1.857,1.148-2.579
                                                          c0.766-0.721,1.74-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543c0.383,0.171,0.653,0.256,0.81,0.256
                                                          c0.178,0,0.323-0.053,0.436-0.159c0.112-0.106,0.203-0.32,0.271-0.641H52.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M58.859,80.618l2.984,4.45c0.827,1.23,1.441,2.008,1.84,2.333
                                                          c0.4,0.325,0.908,0.504,1.523,0.539v0.379h-5.968v-0.379c0.396-0.007,0.69-0.048,0.882-0.123c0.144-0.062,0.261-0.155,0.354-0.282
                                                          c0.092-0.126,0.138-0.255,0.138-0.385c0-0.157-0.031-0.314-0.092-0.472c-0.048-0.116-0.236-0.417-0.564-0.902l-2.358-3.568
                                                          l-2.912,3.732c-0.308,0.396-0.492,0.661-0.554,0.795c-0.062,0.133-0.092,0.271-0.092,0.415c0,0.219,0.092,0.4,0.277,0.543
                                                          s0.537,0.226,1.056,0.246v0.379H50.44v-0.379c0.349-0.034,0.649-0.106,0.902-0.215c0.424-0.178,0.827-0.417,1.21-0.718
                                                          s0.82-0.762,1.313-1.384l3.281-4.143l-2.738-4.009c-0.745-1.087-1.377-1.8-1.897-2.138c-0.52-0.339-1.118-0.518-1.794-0.539
                                                          v-0.379h6.429v0.379c-0.547,0.021-0.921,0.109-1.123,0.267c-0.202,0.157-0.303,0.332-0.303,0.523c0,0.253,0.164,0.622,0.492,1.107
                                                          l2.133,3.189l2.471-3.127c0.287-0.369,0.463-0.622,0.528-0.759s0.098-0.277,0.098-0.42s-0.041-0.27-0.123-0.379
                                                          c-0.103-0.144-0.232-0.244-0.39-0.303c-0.157-0.058-0.482-0.09-0.974-0.097v-0.379h4.932v0.379
                                                          c-0.39,0.021-0.708,0.082-0.954,0.185c-0.369,0.157-0.708,0.369-1.015,0.636s-0.742,0.759-1.302,1.477L58.859,80.618z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M55.675,74.173v5.496h3.056c0.793,0,1.323-0.12,1.589-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.379v4.84h-0.379c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.605-0.564s-0.711-0.205-1.292-0.205h-3.056v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.358c0.786,0,1.357-0.055,1.712-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.858-1.063,1.302-1.917h0.41l-1.2,3.486H51.717v-0.379h0.492
                                                          c0.328,0,0.639-0.079,0.933-0.236c0.219-0.109,0.367-0.273,0.446-0.492s0.118-0.667,0.118-1.343v-9.034
                                                          c0-0.882-0.089-1.425-0.267-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.715l0.154,3.045h-0.4
                                                          c-0.144-0.731-0.302-1.234-0.477-1.507c-0.174-0.273-0.432-0.482-0.774-0.625c-0.273-0.103-0.755-0.154-1.446-0.154H55.675z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M63.38,71.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C63.099,71.304,63.255,71.214,63.38,71.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M71.443,71.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C71.162,71.304,71.318,71.214,71.443,71.214z"/>
                                                    </g>    
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="36.632" y1="78.676" x2="78.632" y2="78.426"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="36.632" y1="82.559" x2="78.632" y2="82.309"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==26}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="50.521" cy="110.307" rx="20.479" ry="13.417"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="49.632" cy="110.285" rx="13.985" ry="11.083"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="27.681" y="95.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="46.353" height="30.424"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="24.07" y1="109.229" x2="74.033" y2="110.716"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M189.874,49.907v4.388h-0.338c-0.11-0.842-0.307-1.512-0.59-2.011
                                                          c-0.284-0.499-0.688-0.895-1.212-1.188c-0.524-0.293-1.067-0.439-1.628-0.439c-0.634,0-1.158,0.198-1.573,0.594
                                                          c-0.414,0.396-0.621,0.847-0.621,1.352c0,0.387,0.131,0.739,0.393,1.057c0.378,0.468,1.277,1.092,2.698,1.871
                                                          c1.158,0.636,1.949,1.125,2.373,1.464s0.75,0.741,0.979,1.202s0.343,0.945,0.343,1.45c0,0.96-0.364,1.788-1.093,2.484
                                                          c-0.729,0.695-1.666,1.043-2.813,1.043c-0.359,0-0.697-0.028-1.015-0.084c-0.189-0.032-0.581-0.145-1.175-0.342
                                                          c-0.595-0.196-0.972-0.294-1.13-0.294c-0.152,0-0.272,0.046-0.361,0.14c-0.088,0.094-0.154,0.287-0.196,0.58h-0.339v-4.35h0.339
                                                          c0.158,0.911,0.372,1.592,0.64,2.044c0.269,0.452,0.679,0.828,1.23,1.127s1.157,0.449,1.815,0.449
                                                          c0.762,0,1.364-0.206,1.806-0.617c0.442-0.412,0.663-0.898,0.663-1.459c0-0.312-0.084-0.627-0.251-0.945
                                                          c-0.168-0.318-0.429-0.614-0.782-0.889c-0.237-0.188-0.887-0.585-1.948-1.193c-1.061-0.608-1.814-1.093-2.263-1.455
                                                          c-0.448-0.361-0.788-0.761-1.02-1.197c-0.232-0.437-0.348-0.917-0.348-1.441c0-0.911,0.341-1.695,1.023-2.353
                                                          c0.684-0.658,1.552-0.987,2.606-0.987c0.659,0,1.356,0.166,2.095,0.496c0.341,0.156,0.582,0.234,0.723,0.234
                                                          c0.158,0,0.288-0.048,0.389-0.145c0.101-0.096,0.181-0.291,0.242-0.584H189.874z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M50.859,110.618l2.984,4.45c0.827,1.23,1.441,2.008,1.84,2.333
                                                          c0.4,0.325,0.908,0.504,1.523,0.539v0.379h-5.968v-0.379c0.396-0.007,0.69-0.048,0.882-0.123c0.144-0.062,0.261-0.155,0.354-0.282
                                                          c0.092-0.126,0.138-0.255,0.138-0.385c0-0.157-0.031-0.314-0.092-0.472c-0.048-0.116-0.236-0.417-0.564-0.902l-2.358-3.568
                                                          l-2.912,3.732c-0.308,0.396-0.492,0.661-0.554,0.795c-0.062,0.133-0.092,0.271-0.092,0.415c0,0.219,0.092,0.4,0.277,0.543
                                                          s0.537,0.226,1.056,0.246v0.379H42.44v-0.379c0.349-0.034,0.649-0.106,0.902-0.215c0.424-0.178,0.827-0.417,1.21-0.718
                                                          s0.82-0.762,1.313-1.384l3.281-4.143l-2.738-4.009c-0.745-1.087-1.377-1.8-1.897-2.138c-0.52-0.339-1.118-0.518-1.794-0.539
                                                          v-0.379h6.429v0.379c-0.547,0.021-0.921,0.109-1.123,0.267c-0.202,0.157-0.303,0.332-0.303,0.523c0,0.253,0.164,0.622,0.492,1.107
                                                          l2.133,3.189l2.471-3.127c0.287-0.369,0.463-0.622,0.528-0.759s0.098-0.277,0.098-0.42s-0.041-0.27-0.123-0.379
                                                          c-0.103-0.144-0.232-0.244-0.39-0.303c-0.157-0.058-0.482-0.09-0.974-0.097v-0.379h4.932v0.379
                                                          c-0.39,0.021-0.708,0.082-0.954,0.185c-0.369,0.157-0.708,0.369-1.015,0.636s-0.742,0.759-1.302,1.477L50.859,110.618z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M47.675,104.173v5.496h3.056c0.793,0,1.323-0.12,1.589-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.379v4.84h-0.379c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.605-0.564s-0.711-0.205-1.292-0.205h-3.056v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.358c0.786,0,1.357-0.055,1.712-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.858-1.063,1.302-1.917h0.41l-1.2,3.486H43.717v-0.379h0.492
                                                          c0.328,0,0.639-0.079,0.933-0.236c0.219-0.109,0.367-0.273,0.446-0.492s0.118-0.667,0.118-1.343v-9.034
                                                          c0-0.882-0.089-1.425-0.267-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.715l0.154,3.045h-0.4
                                                          c-0.144-0.731-0.302-1.234-0.477-1.507c-0.174-0.273-0.432-0.482-0.774-0.625c-0.273-0.103-0.755-0.154-1.446-0.154H47.675z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M55.38,101.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C55.099,101.304,55.255,101.214,55.38,101.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M63.443,101.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C63.162,101.304,63.318,101.214,63.443,101.214z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="28.632" y1="108.468" x2="70.632" y2="108.218"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="28.632" y1="112.351" x2="70.632" y2="112.101"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==27}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="43.521" cy="146.307" rx="20.479" ry="13.417"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="43.632" cy="147.078" rx="14.985" ry="11.875"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="20.681" y="130.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="46.353" height="30.424"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <line fill="none" class="ausente" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="5" x1="20.681" y1="145.235" x2="65.034" y2="144.908"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M46.915,140.097v4.809h-0.379c-0.123-0.923-0.344-1.658-0.661-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.441,1.159c0.424,0.513,1.432,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.661,1.604c0.475,0.373,0.841,0.812,1.098,1.318c0.256,0.506,0.384,1.036,0.384,1.589
                                                          c0,1.053-0.409,1.96-1.225,2.723c-0.817,0.762-1.868,1.143-3.153,1.143c-0.403,0-0.783-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.318-0.374c-0.666-0.216-1.088-0.323-1.266-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          c-0.1,0.103-0.173,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.417,1.745,0.718,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          s1.297,0.492,2.036,0.492c0.854,0,1.529-0.226,2.025-0.677s0.744-0.984,0.744-1.6c0-0.342-0.094-0.687-0.282-1.036
                                                          c-0.188-0.349-0.48-0.673-0.877-0.974c-0.267-0.205-0.995-0.641-2.184-1.307c-1.189-0.667-2.036-1.198-2.538-1.595
                                                          c-0.503-0.396-0.884-0.834-1.144-1.313s-0.39-1.005-0.39-1.579c0-0.998,0.383-1.857,1.148-2.579
                                                          c0.766-0.721,1.74-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543c0.383,0.171,0.653,0.256,0.81,0.256
                                                          c0.178,0,0.323-0.053,0.436-0.159c0.112-0.106,0.203-0.32,0.271-0.641H46.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g class="exodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M44.859,147.618l2.984,4.45c0.827,1.23,1.441,2.008,1.84,2.333
                                                          c0.4,0.325,0.908,0.504,1.523,0.539v0.379h-5.968v-0.379c0.396-0.007,0.69-0.048,0.882-0.123c0.144-0.062,0.261-0.155,0.354-0.282
                                                          c0.092-0.126,0.138-0.255,0.138-0.385c0-0.157-0.031-0.314-0.092-0.472c-0.048-0.116-0.236-0.417-0.564-0.902l-2.358-3.568
                                                          l-2.912,3.732c-0.308,0.396-0.492,0.661-0.554,0.795c-0.062,0.133-0.092,0.271-0.092,0.415c0,0.219,0.092,0.4,0.277,0.543
                                                          s0.537,0.226,1.056,0.246v0.379H36.44v-0.379c0.349-0.034,0.649-0.106,0.902-0.215c0.424-0.178,0.827-0.417,1.21-0.718
                                                          s0.82-0.762,1.313-1.384l3.281-4.143l-2.738-4.009c-0.745-1.087-1.377-1.8-1.897-2.138c-0.52-0.339-1.118-0.518-1.794-0.539
                                                          v-0.379h6.429v0.379c-0.547,0.021-0.921,0.109-1.123,0.267c-0.202,0.157-0.303,0.332-0.303,0.523c0,0.253,0.164,0.622,0.492,1.107
                                                          l2.133,3.189l2.471-3.127c0.287-0.369,0.463-0.622,0.528-0.759s0.098-0.277,0.098-0.42s-0.041-0.27-0.123-0.379
                                                          c-0.103-0.144-0.232-0.244-0.39-0.303c-0.157-0.058-0.482-0.09-0.974-0.097v-0.379h4.932v0.379
                                                          c-0.39,0.021-0.708,0.082-0.954,0.185c-0.369,0.157-0.708,0.369-1.015,0.636s-0.742,0.759-1.302,1.477L44.859,147.618z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g class="endodoncia">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M41.675,141.173v5.496h3.056c0.793,0,1.323-0.12,1.589-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.379v4.84h-0.379c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.605-0.564s-0.711-0.205-1.292-0.205h-3.056v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.358c0.786,0,1.357-0.055,1.712-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.858-1.063,1.302-1.917h0.41l-1.2,3.486H37.717v-0.379h0.492
                                                          c0.328,0,0.639-0.079,0.933-0.236c0.219-0.109,0.367-0.273,0.446-0.492s0.118-0.667,0.118-1.343v-9.034
                                                          c0-0.882-0.089-1.425-0.267-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.715l0.154,3.045h-0.4
                                                          c-0.144-0.731-0.302-1.234-0.477-1.507c-0.174-0.273-0.432-0.482-0.774-0.625c-0.273-0.103-0.755-0.154-1.446-0.154H41.675z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M49.38,138.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C49.099,138.304,49.255,138.214,49.38,138.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M57.443,138.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C57.162,138.304,57.318,138.214,57.443,138.214z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g class="protesis">
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="22.632" y1="144.261" x2="64.632" y2="144.011"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="22.632" y1="148.144" x2="64.632" y2="147.894"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:when test="${diente[0]==28}">
                                            <c:choose>
                                                <c:when test='${diente[1]=="Caries o recidiva"}'>
                                                    <ellipse class="caries" fill="transparent" stroke="#ED1C24" stroke-width="3" stroke-miterlimit="10" cx="41.521" cy="180.307" rx="20.479" ry="13.417"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Obturado"}'>
                                                    <ellipse fill="transparent" class="obturado" stroke="#1C75BC" stroke-width="3" stroke-miterlimit="10" cx="41.632" cy="180.078" rx="14.985" ry="11.875"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Corona completa"}'>
                                                    <rect x="18.681" y="164.504" fill="none" stroke="#009444" stroke-width="3" stroke-miterlimit="10" width="46.353" height="30.424"/>
                                                </c:when>
                                                <c:when test='${diente[1]=="Ausente"}'>
                                                    <g>
                                                    <g>
                                                    <g>

                                                    <line fill="none" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" x1="18.681" y1="179.716" x2="21.181" y2="179.716"/>

                                                    <line fill="none" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" stroke-dasharray="4.5948,4.5948" x1="25.775" y1="179.716" x2="60.236" y2="179.716"/>

                                                    <line fill="none" stroke="#FFF200" stroke-width="3" stroke-miterlimit="10" x1="62.534" y1="179.716" x2="65.034" y2="179.716"/>
                                                    </g>
                                                    </g>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Sellante"}'>
                                                    <g class="sellante">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M44.915,172.097v4.809h-0.379c-0.123-0.923-0.344-1.658-0.661-2.205
                                                          c-0.318-0.547-0.771-0.981-1.359-1.302s-1.196-0.482-1.825-0.482c-0.711,0-1.299,0.217-1.764,0.651
                                                          c-0.465,0.435-0.697,0.928-0.697,1.482c0,0.424,0.147,0.81,0.441,1.159c0.424,0.513,1.432,1.196,3.025,2.051
                                                          c1.299,0.697,2.186,1.232,2.661,1.604c0.475,0.373,0.841,0.812,1.098,1.318c0.256,0.506,0.384,1.036,0.384,1.589
                                                          c0,1.053-0.409,1.96-1.225,2.723c-0.817,0.762-1.868,1.143-3.153,1.143c-0.403,0-0.783-0.031-1.138-0.092
                                                          c-0.212-0.034-0.651-0.159-1.318-0.374c-0.666-0.216-1.088-0.323-1.266-0.323c-0.171,0-0.306,0.051-0.405,0.154
                                                          c-0.1,0.103-0.173,0.314-0.221,0.636h-0.379v-4.768h0.379c0.178,0.998,0.417,1.745,0.718,2.24c0.301,0.496,0.76,0.908,1.379,1.236
                                                          s1.297,0.492,2.036,0.492c0.854,0,1.529-0.226,2.025-0.677s0.744-0.984,0.744-1.6c0-0.342-0.094-0.687-0.282-1.036
                                                          c-0.188-0.349-0.48-0.673-0.877-0.974c-0.267-0.205-0.995-0.641-2.184-1.307c-1.189-0.667-2.036-1.198-2.538-1.595
                                                          c-0.503-0.396-0.884-0.834-1.144-1.313s-0.39-1.005-0.39-1.579c0-0.998,0.383-1.857,1.148-2.579
                                                          c0.766-0.721,1.74-1.082,2.922-1.082c0.738,0,1.521,0.181,2.348,0.543c0.383,0.171,0.653,0.256,0.81,0.256
                                                          c0.178,0,0.323-0.053,0.436-0.159c0.112-0.106,0.203-0.32,0.271-0.641H44.915z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Exodoncia indicada"}'>
                                                    <g>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M42.859,179.618l2.984,4.45c0.827,1.23,1.441,2.008,1.84,2.333
                                                          c0.4,0.325,0.908,0.504,1.523,0.539v0.379h-5.968v-0.379c0.396-0.007,0.69-0.048,0.882-0.123c0.144-0.062,0.261-0.155,0.354-0.282
                                                          c0.092-0.126,0.138-0.255,0.138-0.385c0-0.157-0.031-0.314-0.092-0.472c-0.048-0.116-0.236-0.417-0.564-0.902l-2.358-3.568
                                                          l-2.912,3.732c-0.308,0.396-0.492,0.661-0.554,0.795c-0.062,0.133-0.092,0.271-0.092,0.415c0,0.219,0.092,0.4,0.277,0.543
                                                          s0.537,0.226,1.056,0.246v0.379H34.44v-0.379c0.349-0.034,0.649-0.106,0.902-0.215c0.424-0.178,0.827-0.417,1.21-0.718
                                                          s0.82-0.762,1.313-1.384l3.281-4.143l-2.738-4.009c-0.745-1.087-1.377-1.8-1.897-2.138c-0.52-0.339-1.118-0.518-1.794-0.539
                                                          v-0.379h6.429v0.379c-0.547,0.021-0.921,0.109-1.123,0.267c-0.202,0.157-0.303,0.332-0.303,0.523c0,0.253,0.164,0.622,0.492,1.107
                                                          l2.133,3.189l2.471-3.127c0.287-0.369,0.463-0.622,0.528-0.759s0.098-0.277,0.098-0.42s-0.041-0.27-0.123-0.379
                                                          c-0.103-0.144-0.232-0.244-0.39-0.303c-0.157-0.058-0.482-0.09-0.974-0.097v-0.379h4.932v0.379
                                                          c-0.39,0.021-0.708,0.082-0.954,0.185c-0.369,0.157-0.708,0.369-1.015,0.636s-0.742,0.759-1.302,1.477L42.859,179.618z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Endodoncia"}'>
                                                    <g>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M39.675,173.173v5.496h3.056c0.793,0,1.323-0.12,1.589-0.359
                                                          c0.355-0.314,0.554-0.868,0.595-1.661h0.379v4.84h-0.379c-0.096-0.677-0.191-1.111-0.287-1.302
                                                          c-0.123-0.239-0.325-0.427-0.605-0.564s-0.711-0.205-1.292-0.205h-3.056v4.583c0,0.615,0.027,0.989,0.082,1.123
                                                          c0.055,0.133,0.15,0.239,0.287,0.317c0.137,0.079,0.396,0.118,0.779,0.118h2.358c0.786,0,1.357-0.055,1.712-0.164
                                                          s0.697-0.325,1.025-0.646c0.424-0.424,0.858-1.063,1.302-1.917h0.41l-1.2,3.486H35.717v-0.379h0.492
                                                          c0.328,0,0.639-0.079,0.933-0.236c0.219-0.109,0.367-0.273,0.446-0.492s0.118-0.667,0.118-1.343v-9.034
                                                          c0-0.882-0.089-1.425-0.267-1.63c-0.246-0.273-0.656-0.41-1.23-0.41h-0.492v-0.379h10.715l0.154,3.045h-0.4
                                                          c-0.144-0.731-0.302-1.234-0.477-1.507c-0.174-0.273-0.432-0.482-0.774-0.625c-0.273-0.103-0.755-0.154-1.446-0.154H39.675z"/>
                                                    </g>
                                                </c:when>
                                                <c:when test='${diente[1]=="Incluido"}'>
                                                    <g class="incluido">
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M47.38,170.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C47.099,170.304,47.255,170.214,47.38,170.214z"/>
                                                    <path stroke="#000000" stroke-miterlimit="10" d="M55.443,170.214c0.102,0,0.195,0.051,0.281,0.152
                                                          c0.063,0.086,0.094,0.176,0.094,0.27c0,0.18-0.133,0.414-0.398,0.703c-0.109,0.141-0.211,0.266-0.305,0.375
                                                          s-0.297,0.34-0.609,0.691c-1.016,1.117-2.934,3.492-5.754,7.125c-1.859,2.391-3.379,4.379-4.559,5.965
                                                          c-1.117,1.586-2.219,3.141-3.305,4.664l-1.277,1.816c-0.453,0.672-0.707,1.059-0.762,1.16c-0.156,0.266-0.328,0.398-0.516,0.398
                                                          c-0.25,0-0.375-0.109-0.375-0.328c0-0.258,0.301-0.836,0.902-1.734c1.859-2.797,4.551-6.488,8.074-11.074
                                                          c3.859-5.008,6.297-8.055,7.313-9.141c0.406-0.43,0.648-0.688,0.727-0.773C55.162,170.304,55.318,170.214,55.443,170.214z"/>
                                                    </g>
                                                </c:when>
                                                <c:otherwise>
                                                    <g>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="20.132" y1="178.261" x2="62.132" y2="178.011"/>
                                                    <line fill="none" stroke="#000000" stroke-width="3" stroke-miterlimit="10" x1="20.132" y1="182.144" x2="62.132" y2="181.894"/>
                                                    </g>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                    </c:choose>


                                </c:forEach>
                            </c:otherwise>
                        </c:choose>     
                        </g>
                        </svg>
                        </div>
                        
                    </div>
                    <div class="span6">
                        <h3>Dentici&oacute;n temporal</h3>
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
                        <form action="" id="formDiente" name="formDiente" method="post" style="margin-bottom: 0px;">
                            <fieldset>
                                <div class="modal-header">
                                    <div class="row" style="text-align: center;">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h3 id="dienteSeleccionado"></h3>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <h4 id="zonaSeleccionada">Zona Seleccionada: </h4>
                                    <div class="row">
                                        <div class="span6">
                                            <div style="text-align: center;" id="dibujarDiente">
                                                <svg version="1.1" id="Layer" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                     width="230px" height="230px" viewBox="0 0 230 230" enable-background="new 0 0 230 230" xml:space="preserve">
                                                <g>
                                                <path fill="#010101" d="M224.5,97.035c0,11.947,0,23.869,0,35.815c-12.536,47.17-43.923,75.439-89.534,89.535
                                                      c-12.792,0-25.581,0-38.373,0C48.679,209.748,17.496,180.404,4.5,132.85c0-11.946,0-23.868,0-35.815
                                                      C17.803,49.786,48.5,19.959,96.593,7.5c11.947,0,23.867,0,35.814,0C180.321,20.137,211.504,49.479,224.5,97.035z M181.012,178.896
                                                      c37.912-16.936,38.012-94.676,10.232-122.791c-18.571,7.01-27.244,23.919-38.373,38.373c6.422,12.969,6.422,33.05,0,46.046
                                                      C162.056,153.494,173.696,164.031,181.012,178.896z M142.641,81.686c12.893-11.818,27.014-22.435,33.255-40.93
                                                      C145.912,13.358,66.637,12.821,47.988,50.988c15.937,7.931,23.356,24.404,40.93,30.697
                                                      C101.761,69.611,128.291,74.626,142.641,81.686z M173.337,191.686c-8.313-16.423-17.473-31.977-33.256-40.93
                                                      c-9.772,15.604-42.233,10.54-56.278,2.559c-6.779,15.374-24.175,20.185-28.14,38.371
                                                      C84.442,214.197,144.559,214.197,173.337,191.686z M81.244,120.059c2.559,40.393,66.741,36.528,63.954-5.117
                                                      c-1.229-18.239-13.661-33.153-40.931-25.582C88.023,93.863,80.042,101.255,81.244,120.059z M76.128,140.523
                                                      c-12.792-11.307-6.856-38.219,0-51.164c-16.321-7.546-23.612-24.148-40.931-30.697C11.203,87.186,10.358,159.25,45.43,176.337
                                                      C57.505,166.232,68.069,154.618,76.128,140.523z"/>
                                                <path class="parte" id="mesial1" fill="#FFFFFF" d="M191.244,56.104c27.779,28.115,27.68,105.855-10.232,122.791c-7.315-14.864-18.956-25.401-28.141-38.372
                                                      c6.422-12.996,6.422-33.077,0-46.046C164,80.024,172.673,63.114,191.244,56.104z"/>
                                                <path class="parte" id="vestibular1" fill="#FFFFFF" d="M175.896,40.756c-6.241,18.495-20.362,29.111-33.255,40.93c-14.35-7.059-40.88-12.075-53.722,0
                                                      c-17.574-6.293-24.993-22.766-40.93-30.697C66.637,12.821,145.912,13.358,175.896,40.756z"/>
                                                <path class="parte" id="palatinaLingual1" fill="#FFFFFF" d="M140.081,150.756c15.783,8.953,24.942,24.507,33.256,40.93c-28.778,22.512-88.895,22.512-117.674,0
                                                      c3.964-18.187,21.361-22.997,28.14-38.371C97.848,161.296,130.309,166.359,140.081,150.756z"/>
                                                <path class="parte" id="oclusal1" fill="#FFFFFF" d="M145.198,114.942c2.787,41.645-61.396,45.509-63.954,5.117c-1.202-18.804,6.779-26.196,23.023-30.699
                                                      C131.537,81.789,143.969,96.703,145.198,114.942z"/>
                                                <path class="parte" id="distal1" fill="#FFFFFF" d="M76.128,89.36c-6.856,12.945-12.792,39.857,0,51.164c-8.059,14.095-18.623,25.709-30.699,35.813
                                                      C10.358,159.25,11.203,87.186,35.198,58.663C52.517,65.212,59.807,81.814,76.128,89.36z"/>
                                                </g>
                                                </svg>
                                            </div>
                                        </div>    

                                        <div class="span4" style="text-align: left; margin-left: 30px;">
                                            <h4>Convenciones</h4>
                                            <input type="checkbox" name="enfermedad" value="Caries o recidiva"> Caries o recidiva<br/>
                                            <input type="checkbox" name="enfermedad" value="Obturado"> Obturado<br/>
                                            <input type="checkbox" name="enfermedad" value="Corona completa"> Corona completa<br/>
                                            <input type="checkbox" name="enfermedad" value="Ausente"> Ausente<br/>
                                            <input type="checkbox" name="enfermedad" value="Sellante"> Sellante<br/>
                                            <input type="checkbox" name="enfermedad" value="Exodoncia indicada"> Exodoncia indicada<br/>
                                            <input type="checkbox" name="enfermedad" value="Endodoncia"> Endodoncia<br/>
                                            <input type="checkbox" name="enfermedad" value="Incluido"> Incluido<br/>
                                            <input type="checkbox" name="enfermedad" value="Pr&oacute;tesis existente"> Pr&oacute;tesis existente<br/>
                                        </div>

                                    </div>
                                    <div class="row" style="display: none;">
                                        <div class="span6" style="text-align:right;">
                                            <h4>Elija Zona</h4>
                                            <select id="zonaeditar" multiple="true" size="6" name="zonaeditar" class="{required:true}">
                                                <option id="mesial" value="Mesial">Mesial</option>
                                                <option id="vestibular" value="Vestibular">Vestibular</option>
                                                <option id="distal" value="Distal">Distal</option>
                                                <option id="palatinaLingual" value="Palatina">Palatina</option>
                                                <option id="oclusal" value="Oclusal">Oclusal</option>
                                            </select>
                                        </div>
                                    </div>            
                                </div> 
                                <div class="modal-footer">
                                    <button class="btn btn-primary" id="agregarEnfermedad" type="button">Agregar enfermedad</button>
                                    <button class="btn btn-primary" id="eliminarEnfermedad" type="button">Eliminar enfermedad</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>

                </div>                             
            </div>
        </div>

        <!-----------------PESTANA 5---------------------------->
        <div class="tab-pane fade" id="odontoFi">
            <div class="span12">
                <form class="form-horizontal">
                    <fieldset>
                        <legend>Odontograma final </legend>
                    </fieldset>
                </form>
                <div class="row">
                    <div class="span6">   
                        <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                             width="256px" height="480px" viewBox="0 0 256 480" enable-background="new 0 0 256 480" xml:space="preserve">
                        <image xlink:href="<%=request.getContextPath()%>/images/adultos.gif" height="480" width="256"/>
                        <path class="diente" id="21" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M123,31
                              c-2,0-4,0-6,0c-1.553-7.31-7.598-10.037-8-19c4.839-2.547,9.087-3.995,17-4c0.875,2.316,1.018,4.407,1,8
                              c-2.207,2.51-0.702,7.471-2,11c-0.333,0-0.667,0-1,0C123.667,28.333,123.333,29.667,123,31z"/>
                        <path class="diente" id="11" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M132,8
                              c6.937-0.156,11.367,1.057,16,3c0.333,1,0.667,2,1,3c-0.333,0-0.667,0-1,0c0,1.333,0,2.667,0,4c-0.333,0-0.667,0-1,0
                              c-0.333,1-0.667,2-1,3c-0.667,0.333-1.333,0.667-2,1c0,1.333,0,2.667,0,4c-0.667,0.333-1.333,0.667-2,1c-2.226,2.371-2.1,2.937-7,3
                              c-1.412-2.663-2.03-4.22-2-9c-0.333,0-0.667,0-1,0c-0.333-4-0.667-8-1-12c0.333,0,0.667,0,1,0C132,8.667,132,8.333,132,8z"/>
                        <path class="diente" id="22" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M101,16
                              c1.333,0,2.667,0,4,0c0.333,1,0.667,2,1,3c1.999,1.983,3.93,9.699,4,14c-3.122,1.816-3.387,2.982-9,3c-3.083-5.192-8.571-5.908-9-14
                              c1.333-1,2.667-2,4-3c0-0.333,0-0.667,0-1C98.228,16.694,98.791,18.546,101,16z"/>
                        <path class="diente" id="12" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M152,16
                              c2.666,0.333,5.334,0.667,8,1c2.494,3.68,5.646,2.669,6,9c-1,0.667-2,1.333-3,2c0,0.667,0,1.333,0,2c-2.333,1.667-4.667,3.333-7,5
                              c0,0.333,0,0.667,0,1c-1.333,0-2.667,0-4,0c-0.736-1.408-1.797-3.023-3-4c0-3,0-6,0-9C149.727,20.781,151.364,18.781,152,16z"/>
                        <path class="diente" id="23" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M81,46
                              c-0.587-2.239-0.836-2.506-2-4c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2c-0.667-0.333-1.333-0.667-2-1c-0.333-3-0.667-6-1-9
                              c1-0.333,2-0.667,3-1c2.05-1.885,9.224-1.1,13-1c0.667,1,1.333,2,2,3c0.333,0,0.667,0,1,0c2.035,3.18,2.019,8.737,2,14
                              c-4.073,2.366-3.755,3.073-11,3C83.744,46.091,83.986,46.341,81,46z"/>
                        <path class="diente" id="13" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M168,28
                              c4,0,8,0,12,0c0,0.333,0,0.667,0,1c0.333,0,0.667,0,1,0c0.333,3.333,0.667,6.667,1,10c-1.653,1.336-2.504,3.504-4,5
                              c-1.497,1.497-3.658,2.35-5,4c-2.666,0-5.334,0-8,0c-1.584-2.731-2.742-2.446-3-7c0.333,0,0.667,0,1,0c0-2.667,0-5.333,0-8
                              c0.333,0,0.667,0,1,0C165.333,31.333,166.667,29.667,168,28z"/>
                        <path class="diente" id="24" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M72,44
                              c1.333,0,2.667,0,4,0c1.838,2.573,5.846,3.885,7,7c1.969,5.316-2.922,17.98-5,19c-2,0-4,0-6,0c-4.333-2.667-8.667-5.333-13-8
                              c0-2,0-4,0-6c1-0.667,2-1.333,3-2c0-0.667,0-1.333,0-2c1.667-1.333,3.333-2.667,5-4c0.333-0.667,0.667-1.333,1-2
                              C69.669,44.844,70.285,46.006,72,44z"/>
                        <path class="diente" id="14" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M182,44
                              c1.666,0,3.334,0,5,0c4.362,6.566,11.742,6.381,12,18c-5.946,3.375-9.538,7.843-19,8c-2.508-5.632-4.913-9.506-5-18
                              c0.333,0,0.667,0,1,0c0-1,0-2,0-3C177.229,47.034,180.542,46.253,182,44z"/>
                        <path class="diente" id="25" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M55,66
                              c3,0.667,6,1.333,9,2c1.667,2,3.333,4,5,6c0.333,0,0.667,0,1,0c1.156,1.667-0.015,2.291,2,4c0.429,10.435-0.511,18.225-11,18
                              c0-0.333,0-0.667,0-1c-1.667-0.333-3.333-0.667-5-1c0-0.333,0-0.667,0-1c-0.667,0-1.333,0-2,0c-0.667-1-1.333-2-2-3
                              c-0.667,0-1.333,0-2,0c-0.333-0.667-0.667-1.333-1-2c-3.629-3.553-3.116-2.812-3-10c0.333,0,0.667,0,1,0c0.333-2,0.667-4,1-6
                              C50.333,70,52.667,68,55,66z"/>
                        <path class="diente" id="15" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M211,88
                              c-2.238,0.578-2.514,0.835-4,2c0,0.333,0,0.667,0,1c-0.667,0-1.333,0-2,0c-0.333,0.667-0.667,1.333-1,2c-0.667,0-1.333,0-2,0
                              c-3.292,1.694-5.843,2.817-11,3c-1.965-3.534-3.851-4.204-4-10c-0.333,0-0.667,0-1,0c0-2.667,0-5.333,0-8c0.333,0,0.667,0,1,0
                              c0.91-4.117,9.503-14.321,16-12c0,0.333,0,0.667,0,1c0.667,0,1.333,0,2,0c0.667,1,1.333,2,2,3c0.333,0,0.667,0,1,0c0,1,0,2,0,3
                              c1,0.667,2,1.333,3,2c0.333,3.667,0.667,7.333,1,11C210.861,87.139,211.602,86.003,211,88z"/>
                        <path class="diente" id="26" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M48,130
                              c0-0.667,0-1.333,0-2c-3.538-0.286-4.884-1.349-8-2c-0.528-0.918-3-3-3-3c0-5.666,0-11.334,0-17c0.333,0,0.667,0,1,0
                              c0-1.333,0-2.667,0-4c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c1.088-2.019,3.135-3.669,5-5c0-0.333,0-0.667,0-1c3,0,6,0,9,0
                              c3.272,3.681,8.382,4.477,11,9c4.868,4.669,0.086,16.764-1,22c-1.649,0.988-4.335,4.682-5,5C54.667,130,51.333,130,48,130z"/>
                        <path class="diente" id="16" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M205,94
                              c3,0,6,0,9,0c1.558,2.678,4.811,5.019,6,8c2.127,5.329,1.013,14.171,1,21c-1,0.667-2,1.333-3,2c0,0.333,0,0.667,0,1
                              c-2.922,1.916-13.223,3.867-18,4c-1-1.333-2-2.667-3-4c-0.333,0-0.667,0-1,0c-0.333-2.333-0.667-4.667-1-7
                              c-0.667-0.333-1.333-0.667-2-1c-0.333-4-0.667-8-1-12c0.333,0,0.667,0,1,0c0-1,0-2,0-3c0.333,0,0.667,0,1,0c1.666-2,3.334-4,5-6
                              c0.667,0,1.333,0,2,0c0-0.333,0-0.667,0-1C203.005,94.855,203.43,95.81,205,94z"/>
                        <path class="diente" id="27" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M29,156
                              c-0.333-2.667-0.667-5.333-1-8c0.333,0,0.667,0,1,0c0.333-4.333,0.667-8.667,1-13c5.729-3.439,2.617-5.084,13-5c0,0.333,0,0.667,0,1
                              c2,0.333,4,0.667,6,1c0,0.333,0,0.667,0,1c1.333,0.333,2.667,0.667,4,1c0,0.333,0,0.667,0,1c1.667,1.333,3.333,2.667,5,4
                              c0,2,0,4,0,6c2.452,2.627,0.274,9.513,0,13c-4.945,2.971-3.138,5.032-12,5c-2.157-1.875-5.807,0.217-9-1c0-0.333,0-0.667,0-1
                              c-0.667,0-1.333,0-2,0c0-0.333,0-0.667,0-1C32.905,158.35,31.989,156.811,29,156z"/>
                        <path class="diente" id="17" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M215,130
                              c3,0,6,0,9,0c0.781,1.433,2.771,4.012,4,5c0.262,4.533,2.76,11.489,1,17c-0.333,0-0.667,0-1,0c-0.333,1.667-0.667,3.333-1,5
                              c-1.333,1-2.667,2-4,3c0,0.333,0,0.667,0,1c-3.488,2.225-12.241,2.021-18,2c-2.11-3.522-4.662-3.33-5-9c-0.333,0-0.667,0-1,0
                              c0.333-4.666,0.667-9.334,1-14c0.333,0,0.667,0,1,0c1.054-3.91,2.848-4.206,6-6c0-0.333,0-0.667,0-1c0.667,0,1.333,0,2,0
                              c0-0.333,0-0.667,0-1c2-0.333,4-0.667,6-1C215,130.667,215,130.333,215,130z"/>
                        <path class="diente" id="28" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M54,192
                              c-1,0.333-2,0.667-3,1c0,0.333,0,0.667,0,1c-1,0-2,0-3,0c-0.333,0.667-0.667,1.333-1,2c-3.374,1.427-12.843-0.897-14-2
                              c-4.074-0.94-4.166-2.933-4-8c-1.046-1.069-1.956-7.444-1-10c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0
                              c0-1,0-2,0-3c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0
                              c1.334-1.492,0.491-1.39,3-2c2.414-2.242,8.219-0.217,12,0c2.099,3.092,1.43,0.431,4,2c1.667,2,3.333,4,5,6
                              c0.122,3.417,1.456,11.935,0,15c-0.333,0-0.667,0-1,0C54.908,189.646,54.635,189.68,54,192z"/>
                        <path class="diente" id="18" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M204,192
                              c-0.631-2.264-0.855-2.442-2-4c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2c-0.333,0-0.667,0-1,0c-0.421-1.681,0.954-1.777,1-2
                              c0.872-4.218,0.368-9.609,1-13c2.666-2,5.334-4,8-6c5.493-0.308,8.712-0.976,14,0c1.666,2.333,3.334,4.667,5,7c0,1,0,2,0,3
                              c0.333,0,0.667,0,1,0c-0.333,5.666-0.667,11.334-1,17c-1.801,0.944-1.574,1.385-4,2c-1.28,1.317-9.364,3.406-13,2
                              c0-0.333,0-0.667,0-1c-0.667,0-1.333,0-2,0c0-0.333,0-0.667,0-1C207.956,192.485,207.598,192.333,204,192z"/>
                        <path class="diente" id="38" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M29,293
                              c0.667,0,1.333,0,2,0c0.333-0.667,0.667-1.333,1-2c3.667,0,7.333,0,11,0c2.436,3.876,7.411,6.463,9,11
                              c2.569,7.336-4.246,12.681-8,14c-3.179,1.117-6.893-0.577-9-1c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0
                              C28.932,307.328,28.981,300.791,29,293z"/>
                        <path class="diente" id="48" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M214,291
                              c4,0,8,0,12,0c2.329,4.426,2.087,7.073,2,14c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-2.847,5.817-5.08,8.125-14,8c0-0.333,0-0.667,0-1
                              c-1,0-2,0-3,0c0-0.333,0-0.667,0-1c-2.074-1.632-3.199-1.929-4-5c-0.333,0-0.667,0-1,0c0-2.333,0-4.667,0-7
                              c2.001-1.721,0.843-2.322,2-4c0.667-0.333,1.333-0.667,2-1C210.666,295,212.334,293,214,291z"/>
                        <path class="diente" id="37" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M42,317
                              c3.826-0.038,6.271,0.478,9,1c0.655,1.181,1.622,1.426,2,2c0,0.667,0,1.333,0,2c0.667,0.333,1.333,0.667,2,1
                              c2.423,4.643,1.968,14.74,1,20c-6.777,4.04-3.736,7.058-16,7c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c0-0.667,0-1.333,0-2
                              c-0.333,0-0.667,0-1,0c0-1.333,0-2.667,0-4c-2.424-7.201-2.98-13.708,0-21c1.007-0.493,1.834-1.915,2-2c1.333,0,2.667,0,4,0
                              C42,317.667,42,317.333,42,317z"/>
                        <path class="diente" id="47" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M207,317
                              c6.669-0.242,11.603-0.045,14,4c5.159,4.973,0.149,20.699-1,26c-4.072,2.366-3.755,3.072-11,3c-2.073-3.201-4.485-2.281-7-3
                              c-0.333-1-0.667-2-1-3c-0.333,0-0.667,0-1,0c0-1,0-2,0-3c-0.333,0-0.667,0-1,0c1-5.999,2-12.001,3-18c1-0.667,2-1.333,3-2
                              c0-0.667,0-1.333,0-2C205.42,318.38,206.324,318.206,207,317z"/>
                        <path class="diente" id="36" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M65,356
                              c1.212,5.808,6.633,18.622,0,23c0,0.333,0,0.667,0,1c-1.333,0-2.667,0-4,0c-0.333,0.667-0.667,1.333-1,2
                              c-2.279,1.803-4.781,1.989-9,2c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c-0.333-1.333-0.667-2.667-1-4
                              c-0.667-0.333-1.333-0.667-2-1c0-1.333,0-2.667,0-4c-2.07-5.98-3.186-10.225-2-17c4.736-2.119,8.781-3.902,16-4
                              c0.702,1.412,1.439,1.227,2,2c0,0.667,0,1.333,0,2C61.954,356.094,63.039,355.772,65,356z"/>
                        <path class="diente" id="46" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M197,351
                              c7.543-0.311,15.506,0.53,17,6c0.333,0,0.667,0,1,0c-0.333,4-0.667,8-1,12c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-0.333,0-0.667,0-1,0
                              c0,1,0,2,0,3c-0.333,0-0.667,0-1,0c0,1,0,2,0,3c-0.667,0.333-1.333,0.667-2,1c0,0.667,0,1.333,0,2c-1,0.667-2,1.333-3,2
                              c0,0.333,0,0.667,0,1c-2,0-4,0-6,0c-2.581-3.831-7.61-3.807-9-9c-0.333,0-0.667,0-1,0c0.667-5.333,1.333-10.667,2-16
                              c0.667-0.333,1.333-0.667,2-1c0.333-1.666,0.667-3.334,1-5c0.667,0,1.333,0,2,0C197,352.333,197,351.667,197,351z"/>
                        <path class="diente" id="35" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M61,385
                              c2,0,4,0,6,0c0.61,1.152,1.706,1.521,2,2c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0.333,2,0.667,4,1,6c0.333,0,0.667,0,1,0
                              c0,1.333,0,2.667,0,4c0.333,0,0.667,0,1,0c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0,2,0,4,0,6c-5.47,4.732-4.066,7.863-14,6
                              c-0.667-1-1.333-2-2-3c-0.333,0-0.667,0-1,0c-1.797-2.803-5.433-16.242-3-20C56.333,388.334,58.667,386.666,61,385z"/>
                        <path class="diente" id="45" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M190,385
                              c2,0,4,0,6,0c0,0.333,0,0.667,0,1c0.667,0,1.333,0,2,0c1.666,2,3.334,4,5,6c0.333,0,0.667,0,1,0c0,2.666,0,5.334,0,8
                              c-0.333,0-0.667,0-1,0c-0.333,2-0.667,4-1,6c-3.206,7.058-6.998,9.379-15,6c-1.936-4.629-3.002-5.896-3-13c0.333,0,0.667,0,1,0
                              c0.333-2.333,0.667-4.667,1-7c0.333,0,0.667,0,1,0C188.246,389.43,188.928,387.353,190,385z"/>
                        <path class="diente" id="34" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M77,409
                              c1,0,2,0,3,0c0.701,1.16,2.855,2.737,3,3c0.333,2,0.667,4,1,6c0.333,0,0.667,0,1,0c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0
                              c1.698,4.665,0.11,14.455-3,16c-2,0-4,0-6,0c-2.61-4.188-15.267-11.839-10-20c0.333,0,0.667,0,1,0
                              C70.631,412.734,74.458,411.985,77,409z"/>
                        <path class="diente" id="44" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M177,409
                              c1,0,2,0,3,0c0,0.333,0,0.667,0,1c5.15,1.128,10.986,6.378,11,13c-1.997,1.723-0.844,2.323-2,4c-3.666,3.333-7.334,6.667-11,10
                              c-5.426-2.079-7.824-4.74-8-12c1.767-2.017,0.83-5.403,2-8c0.333,0,0.667,0,1,0c0-0.667,0-1.333,0-2c0.667-0.333,1.333-0.667,2-1
                              c0-0.667,0-1.333,0-2c0.333,0,0.667,0,1,0C176.333,411,176.667,410,177,409z"/>
                        <path class="diente" id="33" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M86,434
                              c5.658-1.31,5.227-2.376,11,0c1.335,3.57,1.047,9.913,1,15c-1.139,1.14-0.398,0.004-1,2c-2.437,0.918-6.193,1.037-10,1
                              c-0.333-1-0.667-2-1-3c-1.983-1.896-0.024-0.522-1-3C82.908,440.687,85.323,439.013,86,434z"/>
                        <path class="diente" id="43" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M171,434
                              c0.333,1.333,0.667,2.667,1,4c0.333,0,0.667,0,1,0c1.705,4.959-1.318,9.695-2,13c-2.437,0.918-6.193,1.037-10,1
                              c-0.333-1-0.667-2-1-3c-2.089-2.285-1.101-10.884-1-15c1.135-0.844,0.146,0.127,1-1c2.333-0.333,4.667-0.667,7-1
                              C168.165,433.361,168.824,433.528,171,434z"/>
                        <path class="diente" id="32" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M109,464
                              c-1.333,0-2.667,0-4,0c-2.82-4.167-6.592-2.795-7-10c2.364-1.982,3.36-5.292,6-7c0-0.333,0-0.667,0-1c1.667-0.333,3.333-0.667,5-1
                              c0,0.333,0,0.667,0,1C113.663,449.991,109.424,458.705,109,464z"/>
                        <path class="diente" id="42" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M148,464
                              c0-1.333,0-2.667,0-4c-0.667,0-1.333,0-2,0c0-4.333,0-8.667,0-13c1.867-0.706,3.91-0.993,7-1c2.351,4.258,5.644,5.552,6,12
                              C155.042,460.338,154.241,463.624,148,464z"/>
                        <path class="diente" id="31" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M126,470
                              c-3.667,0-7.333,0-11,0c-0.333-1-0.667-2-1-3c-1.807-1.927-0.969-5.779,0-8c0.333,0,0.667,0,1,0c0.333-2,0.667-4,1-6
                              c2.078-1.094,1.771-1.61,5-2c0.609,1.128,1.713,1.533,2,2c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0c0,1,0,2,0,3c0.333,0,0.667,0,1,0
                              c0,0.667,0,1.333,0,2c0.333,0,0.667,0,1,0C126,463.333,126,466.667,126,470z"/>
                        <path class="diente" id="41" fill-rule="evenodd" clip-rule="evenodd" fill="transparent" stroke="none" stroke-width="0.5" stroke-miterlimit="10" d="M134,452
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
                        <form action="" id="formDiente" name="formDiente" method="post" style="margin-bottom: 0px;">
                            <fieldset>
                                <div class="modal-header">
                                    <div class="row" style="text-align: center;">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        <h3 id="dienteSeleccionado"></h3>
                                    </div>
                                </div>
                                <div class="modal-body">
                                    <h4 id="zonaSeleccionada">Zona Seleccionada: </h4>
                                    <div class="row">
                                        <div class="span6">
                                            <div style="text-align: center;" id="dibujarDiente">
                                                <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                                                     width="150px" height="100px" viewBox="0 0 150 100" enable-background="new 0 0 150 100" xml:space="preserve">
                                                <g id="XMLID_2_">
                                                <g>
                                                <path d="M118,43c0,4.67,0,9.33,0,14c-4.9,18.44-17.17,29.49-35,35c-5,0-10,0-15,0c-18.73-4.94-30.92-16.41-36-35
                                                      c0-4.67,0-9.33,0-14c5.2-18.47,17.2-30.13,36-35c4.67,0,9.33,0,14,0C100.73,12.94,112.92,24.41,118,43z M101,75
                                                      c14.82-6.62,14.86-37.01,4-48c-7.26,2.74-10.65,9.35-15,15c2.51,5.07,2.51,12.92,0,18C93.59,65.07,98.14,69.19,101,75z M86,37
                                                      c5.04-4.62,10.56-8.77,13-16c-11.72-10.71-42.71-10.92-50,4c6.23,3.1,9.13,9.54,16,12C70.02,32.28,80.39,34.24,86,37z M98,80
                                                      c-3.25-6.42-6.83-12.5-13-16c-3.82,6.1-16.51,4.12-22,1c-2.65,6.01-9.45,7.89-11,15C63.25,88.8,86.75,88.8,98,80z M62,52
                                                      c1,15.79,26.09,14.28,25-2c-0.48-7.13-5.34-12.96-16-10C64.65,41.76,61.53,44.65,62,52z M60,60c-5-4.42-2.68-14.94,0-20
                                                      c-6.38-2.95-9.23-9.44-16-12c-9.38,11.15-9.71,39.32,4,46C52.72,70.05,56.85,65.51,60,60z"/>
                                                <path class="parte" id="mesial1" fill="#FFFFFF" d="M105,27c10.86,10.99,10.82,41.38-4,48c-2.86-5.81-7.41-9.93-11-15c2.51-5.08,2.51-12.93,0-18
                                                      C94.35,36.35,97.74,29.74,105,27z"/>
                                                <path class="parte" id="vestibular1" fill="#FFFFFF" d="M99,21c-2.44,7.23-7.96,11.38-13,16c-5.61-2.76-15.98-4.72-21,0c-6.87-2.46-9.77-8.9-16-12
                                                      C56.29,10.08,87.28,10.29,99,21z"/>
                                                <path class="parte" id="palatinaLingual1" fill="#FFFFFF" d="M85,64c6.17,3.5,9.75,9.58,13,16c-11.25,8.8-34.75,8.8-46,0c1.55-7.11,8.35-8.99,11-15
                                                      C68.49,68.12,81.18,70.1,85,64z"/>
                                                <path class="parte" id="oclusal1" fill="#FFFFFF" d="M87,50c1.09,16.28-24,17.79-25,2c-0.47-7.35,2.65-10.24,9-12C81.66,37.04,86.52,42.87,87,50z"/>
                                                <path class="parte" id="distal1" fill="#FFFFFF" d="M60,40c-2.68,5.06-5,15.58,0,20c-3.15,5.51-7.28,10.05-12,14c-13.71-6.68-13.38-34.85-4-46
                                                      C50.77,30.56,53.62,37.05,60,40z"/>
                                                </g>
                                                <g>
                                                </g>
                                                </g>
                                                </svg>


                                            </div>
                                        </div>    

                                        <div class="span4" style="text-align: left; margin-left: 30px;">
                                            <h4>Convenciones</h4>
                                            <span class="badge"><input type="checkbox" name="enfermedad" value="Caries o recidiva"></span> Caries o recidiva<br/>
                                            <span class="badge badge-success"><input type="checkbox" name="enfermedad" value="Obturado"></span> Obturado<br/>
                                            <span class="badge badge-warning"><input type="checkbox" name="enfermedad" value="Corona completa"></span> Corona completa<br/>
                                            <span class="badge badge-important"><input type="checkbox" name="enfermedad" value="Ausente"></span> Ausente<br/>
                                            <span class="badge badge-info"><input type="checkbox" name="enfermedad" value="Sellante"></span> Sellante<br/>
                                            <span class="badge badge-inverse"><input type="checkbox" name="enfermedad" value="Endodoncia indicada"></span> Endodoncia indicada<br/>
                                            <span class="badge" style="background-color: #330066"><input type="checkbox" name="enfermedad" value="Endodoncia"></span> Endodoncia<br/>
                                            <span class="badge" style="background-color: #330000"><input type="checkbox" name="enfermedad" value="Incluido"></span> Incluido<br/>
                                            <span class="badge" style="background-color: #ffff00"><input type="checkbox" name="enfermedad" value="Pr&oacute;tesis existente"></span> Pr&oacute;tesis existente<br/>
                                        </div>

                                    </div>
                                    <div class="row" style="display: none;">
                                        <div class="span6" style="text-align:right;">
                                            <h4>Elija Zona</h4>
                                            <select id="zonaeditar" multiple="true" size="6" name="zonaeditar" class="{required:true}">
                                                <option id="mesial" value="Mesial">Mesial</option>
                                                <option id="vestibular" value="Vestibular">Vestibular</option>
                                                <option id="distal" value="Distal">Distal</option>
                                                <option id="palatinaLingual" value="Palatina">Palatina</option>
                                                <option id="oclusal" value="Oclusal">Oclusal</option>
                                            </select>
                                        </div>
                                    </div>            
                                </div> 
                                <div class="modal-footer">
                                    <button class="btn btn-primary" type="submit">Guardar Cambios</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>

                </div>                             
            </div>
        </div>

        <!-----------------PESTANA 6---------------------------->
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
<div id="confirmacion" class="modal hide fade">
    <div class="modal-header">
        <a href="#" data-dismiss="modal" class="close">&times;</a>
    </div>
    <div class="modal-body">
        <p>¿Es un procedimiento a realizar?</p>
    </div>
    <div class="modal-footer">
        <a href="#" id="diceSi" class="btn">Si</a>
        <a href="#" id="diceNo" class="btn">No</a>
    </div>
</div>