<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap.min.css">
<!--[if lt IE 7]><link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap-ie6.min.css"><![endif]-->
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<!-- Shim to make HTML5 elements usable in older Internet Explorer versions -->
<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
<!-- Bootstrap styles for responsive website layout, supporting different screen sizes -->
<link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap-responsive.min.css">
<!-- Bootstrap CSS fixes for IE6 -->
<!--[if lt IE 7]><link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap-ie6.min.css"><![endif]-->
<!-- Bootstrap Image Gallery styles -->
<link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap.min.css">
<!--[if lt IE 7]><link rel="stylesheet" href="http://blueimp.github.com/cdn/css/bootstrap-ie6.min.css"><![endif]-->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-image-gallery.min.css">
<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/jquery.fileupload-ui.css">

<script src='<%=request.getContextPath()%>/js/jquery.reel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.disabletextselect-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.mousewheel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.cookie-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/sampler.js' type='text/javascript'></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.ba-hashchange.js"></script>
<style type="text/css">
    .diente, .mini, .mini2{
        cursor: pointer;
    }
    .badge input{
        margin-top: -2px;
    }
    .span4 input[type="checkbox"]{
        margin-top: 0px;
    } 
</style>
<script type="text/javascript">
    $(function() {

        $('.ultima').datepicker();
        $('.fecha').datepicker();

        $("#agregarControl").click(function(){
            if($("#formControl input[name='hidden-tags10']").val()!="" && $("#formControl input[name='fechaTrat10']").val()!=""){
                $.ajax({
                    type: 'POST',
                    url: "<%=request.getContextPath()%>/formController?action=agregarControl",
                    data: "" + $("#formControl").serialize(),
                    success: function() {
                        setTimeout(function() {
                            $("<tr>"
                                +"<td>"+$('#fechaTrat10').val()+"</td>"
                                +"<td>"+ $("#formControl input[name='hidden-tags10']").val()+"</td>"
                                +"</tr>").insertBefore('#controles tr:last');
                            $('#formControl').each (function(){
                                this.reset();
                            });
                            $(".tagManager10").tagsManager('empty');
                            $("#agregarControl").button('reset');
                        }, 500);

                    } //fin success
                }); //fin $.ajax       
            }
            
        });
        $("#agregarEnfermedad").click(function() {
            var idDiente = $("#dienteSeleccionado").text().split(" ");
            if (!$("#zonaeditar option:selected").val()) {
                alert("Seleccione al menos una cara");
            } else {
                if ($("input[name='enfermedad']:checked").length == "") {
                    alert("Seleccione al menos una convención");
                } else {
                    if (confirm("¿Es un procedimiento a realizar?")) {

                        $.ajax({
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/formController?action=agregarEnfermedad",
                            data: $("#formDiente").serialize() + "&diente=" + idDiente[1] + "&realizar=Si",
                            success: function() {
                                $.ajax({
                                    type: 'POST',
                                    url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                    success: function(data) {
                                        $("#dibujarDiente").html(data);
                                        $.ajax({
                                            type: 'POST',
                                            url: "<%=request.getContextPath()%>/formController?action=actualizaBoca",
                                            success: function() {
                                                $.ajax({
                                                    type: 'POST',
                                                    url: "/Odontogramas/vista/consulta/bocaAdulto.jsp",
                                                    success: function(data) {
                                                        $("#bocaAdulto").empty();
                                                        setTimeout(function() {
                                                            $("#bocaAdulto").append(data);
                                                        }, 100);


                                                    } //fin success
                                                }); //fin $.ajax     

                                            } //fin success
                                        }); //fin $.ajax
                                    }
                                })
                            }
                        })



                    } else {
                        $.ajax({
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/formController?action=agregarEnfermedad",
                            data: $("#formDiente").serialize() + "&diente=" + idDiente[1] + "&realizar=No",
                            success: function() {
                                $.ajax({
                                    type: 'POST',
                                    url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                    success: function(data) {
                                        $("#dibujarDiente").html(data);
                                        $.ajax({
                                            type: 'POST',
                                            url: "<%=request.getContextPath()%>/formController?action=actualizaBoca",
                                            success: function() {
                                                $.ajax({
                                                    type: 'POST',
                                                    url: "/Odontogramas/vista/consulta/bocaAdulto.jsp",
                                                    success: function(data) {
                                                        $("#bocaAdulto").empty();
                                                        setTimeout(function() {
                                                            $("#bocaAdulto").append(data);
                                                        }, 200);


                                                    } //fin success
                                                }); //fin $.ajax  

                                                $.ajax({
                                                    type: 'POST',
                                                    url: "/Odontogramas/vista/consulta/bocaAdultoFinal.jsp",
                                                    success: function(data) {
                                                        $("#bocaAdultoFinal").empty();
                                                        setTimeout(function() {
                                                            $("#bocaAdultoFinal").append(data);
                                                        }, 500);


                                                    } //fin success
                                                }); //fin $.ajax

                                            } //fin success
                                        }); //fin $.ajax


                                    }
                                })
                            }
                        })
                    }
                }

            }
        })


        $("#agregarEnfermedad2").click(function() {
            var idDiente = $("#dienteSeleccionado2").text().split(" ");
            if (!$("#zonaeditar2 option:selected").val()) {
                alert("Seleccione al menos una cara");
            } else {
                if ($("input[name='enfermedad']:checked").length == "") {
                    alert("Seleccione al menos una convención");
                } else {
                    if (confirm("¿Es un procedimiento a realizar?")) {

                        $.ajax({
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/formController?action=agregarEnfermedad",
                            data: $("#formDiente2").serialize() + "&diente=" + idDiente[1] + "&realizar=Si",
                            success: function() {
                                $.ajax({
                                    type: 'POST',
                                    url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                    success: function(data) {
                                        $("#dibujarDiente2").html(data);
                                        $.ajax({
                                            type: 'POST',
                                            url: "<%=request.getContextPath()%>/formController?action=actualizaBoca",
                                            success: function() {
                                                $.ajax({
                                                    type: 'POST',
                                                    url: "/Odontogramas/vista/consulta/bocaNino.jsp",
                                                    success: function(data) {
                                                        $("#bocaNino").empty();
                                                        setTimeout(function() {
                                                            $("#bocaNino").append(data);
                                                        }, 100);


                                                    } //fin success
                                                }); //fin $.ajax     

                                            } //fin success
                                        }); //fin $.ajax
                                    }
                                })
                            }
                        })



                    } else {
                        $.ajax({
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/formController?action=agregarEnfermedad",
                            data: $("#formDiente2").serialize() + "&diente=" + idDiente[1] + "&realizar=No",
                            success: function() {
                                $.ajax({
                                    type: 'POST',
                                    url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                    success: function(data) {
                                        $("#dibujarDiente2").html(data);
                                        $.ajax({
                                            type: 'POST',
                                            url: "<%=request.getContextPath()%>/formController?action=actualizaBoca",
                                            success: function() {
                                                $.ajax({
                                                    type: 'POST',
                                                    url: "/Odontogramas/vista/consulta/bocaNino.jsp",
                                                    success: function(data) {
                                                        $("#bocaNino").empty();
                                                        setTimeout(function() {
                                                            $("#bocaNino").append(data);
                                                        }, 100);


                                                    } //fin success
                                                }); //fin $.ajax  
                                                
                                                $.ajax({
                                                    type: 'POST',
                                                    url: "/Odontogramas/vista/consulta/bocaNinoFinal.jsp",
                                                    success: function(data) {
                                                        $("#bocaNinoFinal").empty();
                                                        setTimeout(function() {
                                                            $("#bocaNinoFinal").append(data);
                                                        }, 500);


                                                    } //fin success
                                                }); //fin $.ajax
                                                

                                            } //fin success
                                        }); //fin $.ajax

                                    }
                                })
                            }
                        })
                    }
                }

            }
        })




        $("#eliminarEnfermedad").click(function() {
            if (!$("#zonaeditar option:selected").val()) {
                alert("Seleccione al menos una cara");
            } else {
                if ($("input[name='enfermedad']:checked").length == "") {
                    alert("Seleccione al menos una convención");
                } else {
                    var idDiente = $("#dienteSeleccionado").text().split(" ");

                    $.ajax({
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/formController?action=eliminarEnfermedad",
                        data: $("#formDiente").serialize() + "&diente=" + idDiente[1],
                        success: function() {
                            $.ajax({
                                type: 'POST',
                                url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                success: function(data) {
                                    $("#dibujarDiente").html(data);
                                    $.ajax({
                                        type: 'POST',
                                        url: "<%=request.getContextPath()%>/formController?action=actualizaBoca",
                                        success: function() {
                                            $.ajax({
                                                type: 'POST',
                                                url: "/Odontogramas/vista/consulta/bocaAdulto.jsp",
                                                success: function(data) {
                                                    $("#bocaAdulto").empty();
                                                    setTimeout(function() {
                                                        $("#bocaAdulto").append(data);
                                                    }, 500);


                                                } //fin success
                                            }); //fin $.ajax 

                                            $.ajax({
                                                type: 'POST',
                                                url: "/Odontogramas/vista/consulta/bocaAdultoFinal.jsp",
                                                success: function(data) {
                                                    $("#bocaAdultoFinal").empty();
                                                    setTimeout(function() {
                                                        $("#bocaAdultoFinal").append(data);
                                                    }, 500);


                                                } //fin success
                                            }); //fin $.ajax

                                        } //fin success
                                    }); //fin $.ajax
                                }
                            })
                        }
                    })


                }

            }
        })
        
        
        $("#eliminarEnfermedad2").click(function() {
            if (!$("#zonaeditar2 option:selected").val()) {
                alert("Seleccione al menos una cara");
            } else {
                if ($("input[name='enfermedad']:checked").length == "") {
                    alert("Seleccione al menos una convención");
                } else {
                    var idDiente = $("#dienteSeleccionado2").text().split(" ");

                    $.ajax({
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/formController?action=eliminarEnfermedad",
                        data: $("#formDiente2").serialize() + "&diente=" + idDiente[1],
                        success: function() {
                            $.ajax({
                                type: 'POST',
                                url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                                success: function(data) {
                                    $("#dibujarDiente2").html(data);
                                    $.ajax({
                                        type: 'POST',
                                        url: "<%=request.getContextPath()%>/formController?action=actualizaBoca",
                                        success: function() {
                                            $.ajax({
                                                type: 'POST',
                                                url: "/Odontogramas/vista/consulta/bocaNino.jsp",
                                                success: function(data) {
                                                    $("#bocaNino").empty();
                                                    setTimeout(function() {
                                                        $("#bocaNino").append(data);
                                                    }, 500);


                                                } //fin success
                                            }); //fin $.ajax 

                                            $.ajax({
                                                type: 'POST',
                                                url: "/Odontogramas/vista/consulta/bocaNinoFinal.jsp",
                                                success: function(data) {
                                                    $("#bocaNinoFinal").empty();
                                                    setTimeout(function() {
                                                        $("#bocaNinoFinal").append(data);
                                                    }, 500);


                                                } //fin success
                                            }); //fin $.ajax

                                        } //fin success
                                    }); //fin $.ajax
                                }
                            })
                        }
                    })


                }

            }
        })

        $(".mini").click(function(ev) {
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=asignarDiente",
                data: "diente=" + $(this).attr("id"),
                success: function() {
                    $.ajax({
                        type: 'POST',
                        url: "/Odontogramas/vista/consulta/uploaderX.jsp",
                        success: function(data) {
                            $("#uploaderX").html(data);
                         
                        }
                    })    
                }
            })
           
        })
        
        $("#comparador").live("click",function(ev) {
           
            $.ajax({
                type: 'POST',
                url: "/Odontogramas/vista/consulta/comparador.jsp",
                success: function(data) {
                    $("#uploaderX").html(data);
                         
                }
            })    
               
           
        });

        $(".diente2").click(function(ev) {
            $('#zonaeditar2 option:selected').removeAttr("selected");
            $("#zonaSeleccionada2").html("Zona Seleccionada:");
            $('#derecha2').modal();
            $("#dienteSeleccionado2").text("Diente " + $(this).attr("id"));
            if ($(this).attr("id") > 70 && $(this).attr("id") < 76 || $(this).attr("id") > 80 && $(this).attr("id") < 86) {
                $("#palatinaLingual2").val("Lingual");
                $("#palatinaLingual2").html("Lingual");
            } else {
                $("#palatinaLingual2").val("Palatina");
                $("#palatinaLingual2").html("Palatina");
            }
            var idDiente = $("#dienteSeleccionado2").text().split(" ");
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=verDiente",
                data: "&diente=" + idDiente[1],
                success: function() {
                    $.ajax({
                        type: 'POST',
                        url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                        success: function(data) {
                            $("#dibujarDiente2").html(data);
                        }
                    })
                }
            })



        });


        $(".diente").click(function(ev) {
            $('#zonaeditar option:selected').removeAttr("selected");
            $("#zonaSeleccionada").html("Zona Seleccionada:");
            $('#derecha').modal();
            $("#dienteSeleccionado").text("Diente " + $(this).attr("id"));
            if ($(this).attr("id") > 40 && $(this).attr("id") < 49 || $(this).attr("id") > 30 && $(this).attr("id") < 39) {
                $("#palatinaLingual").val("Lingual");
                $("#palatinaLingual").html("Lingual");
            } else {
                $("#palatinaLingual").val("Palatina");
                $("#palatinaLingual").html("Palatina");
            }
            var idDiente = $("#dienteSeleccionado").text().split(" ");
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=verDiente",
                data: "&diente=" + idDiente[1],
                success: function() {
                    $.ajax({
                        type: 'POST',
                        url: "/Odontogramas/vista/consulta/dibujarDiente.jsp",
                        success: function(data) {
                            $("#dibujarDiente").html(data);
                        }
                    })
                }
            })



        });

        $("#agregarEvol").click(function() {
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarEvolucion",
                data: $("#formEvol").serialize(),
                success: function() {
                    $("#tablaEvol").prepend("<tr>"
                        + "<td>" + $("#fechaE").val() + "</td>"
                        + "<td>" + $("#reciboE").val() + "</td>"
                        + "<td>" + $("#tratamientoE").val() + "</td>"
                        + "</tr>  ");
                    $("fechaE").val("");
                    $("#reciboE").val("");
                    $("#tratamientoE").val("");
                 
                } //fin success
            }); //fin $.ajax    

        });
        $("#guardarDiag").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarDiagnostico",
                data: "diagnosticos=" + $("#formDiag input[name='hidden-tags']").val(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarDiag").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });
        $("#guardarAnte").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarAntecedentes",
                data: ""+$("#formAnte").serialize(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarAnte").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });
        $("#guardarImpresion").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarImpresion",
                data: ""+$("#formImpresion").serialize(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarImpresion").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });
        $("#guardarVitalometrica").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarVitalometrica",
                data: ""+$("#formVitalometrica").serialize(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarVitalometrica").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });
        $("#guardarRadiografico").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarRadiografico",
                data: ""+$("#formRadiografico").serialize(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarRadiografico").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });




        $("#guardarProno").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarPronostico",
                data: $("#formPron").serialize(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarProno").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });


        $("#guardarOtros").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarOtros",
                data: "" + $("#formOtros").serialize(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarOtros").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });

        $(".eliminarPreparacion").live("click",function(e){
            var $this=$(this);
            var href = $(this).attr("href").split("?");
            if(confirm("¿Desea eliminar esta preparación biomedica?")) {
                $.ajax({
                    type: 'POST',
                    url: "<%=request.getContextPath()%>/formController?action=eliminarPreparacion",
                    data: ""+ href[1],
                    success: function() {
                        setTimeout(function() {
                            $($this).parent('td').parent('tr').remove();
                        }, 500);

                    } //fin success
                }); //fin $.ajax    
            
            }else{
                return false;
            } 
        });



        $("#agregarPreparacion").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarPreparacion",
                data: ""+$("#formPreparacion").serialize(),
                success: function(id) {
                    setTimeout(function() {
                        $("<tr>"
                            +"<td>"+$('#canalete').val()+"</td>"
                            +"<td>"+$('#referencia').val()+"</td>"
                            +"<td>"+$('#la').val()+"</td>"
                            +"<td>"+$('#lri').val()+"</td>"
                            +"<td>"+$('#lrt').val()+"</td>"
                            +"<td>"+$('#inst').val()+"</td>"
                            +"<td>"+$('#lima').val()+"</td>"
                            +"<td>"+$('#preparacion').val()+"</td>"
                            +"<td class='action icon16'>"+'<a class="icon-remove eliminarPreparacion" href="#eliminarPreparacion?pid='+id+'" title="Eliminar"></a>'+"</td>"
                            +"</tr>").insertBefore('#tablaPre tr:last');
                        $('#formPreparacion').each (function(){
                            this.reset();
                        });
                        $("#agregarPreparacion").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });
        $("#guardarTrat").click(function() {
            $(this).button('loading');
            $.ajax({
                type: 'POST',
                url: "<%=request.getContextPath()%>/formController?action=agregarTratamiento",
                data: "tratamientos=" + $("#formTrata input[name='hidden-tags2']").val(),
                success: function() {
                    setTimeout(function() {
                        $("#guardarTrat").button('reset');
                    }, 500);

                } //fin success
            }); //fin $.ajax    

        });

        var miArray2 = new Array(${tratamientos.getRowCount()});

    <c:forEach items="${tratamientos.rowsByIndex}" var="item2" varStatus="iter2">
            miArray2[${iter2.index}] = "${item2[1]} - ${item2[0]} - ${item2[2]}";
    </c:forEach> 
            $(".tagManager3").tagsManager({
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


    <c:choose>
        <c:when test="${tratamientosExistentes.getRowCount()==0}">
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
                
        </c:when>
        <c:otherwise>
                var miArrayExT = new Array(${tratamientosExistentes.getRowCount()});
            <c:forEach items="${tratamientosExistentes.rowsByIndex}" var="tratamiento" varStatus="iterT">
                    miArrayExT[${iterT.index}] = "${tratamiento[1]} - ${tratamiento[0]}  - ${tratamiento[2]}";
            </c:forEach>
                  
                    $(".tagManager2").tagsManager({
                        prefilled: miArrayExT,
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
               
        </c:otherwise>    
    </c:choose>
        
    <c:choose>
        <c:when test="${tratamientosExistentes6.getRowCount()==0}">
                $(".tagManager6").tagsManager({
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
                
        </c:when>
        <c:otherwise>
                var miArrayExT6 = new Array(${tratamientosExistentes6.getRowCount()});
            <c:forEach items="${tratamientosExistentes6.rowsByIndex}" var="tratamiento6" varStatus="iterT6">
                    miArrayExT6[${iterT6.index}] = "${tratamiento6[1]} - ${tratamiento6[0]}  - ${tratamiento6[2]}";
            </c:forEach>
                  
                    $(".tagManager6").tagsManager({
                        prefilled: miArrayExT6,
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
               
        </c:otherwise>    
    </c:choose>   
            $(".tagManager10").tagsManager({
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
    
            $("#formTrata input[name='hidden-tags2']").change(function() {
                var tratamiento = $("input[name='hidden-tags2']").val();
                var presupuesto = 0;
                if (tratamiento != "") {
                    var tratamientos = tratamiento.split(",");
                    for (var i = 0; i < tratamientos.length; i++) {
                        var aux = tratamientos[i].split("-");
                        presupuesto += parseInt(aux[2]);
                    }
                }
                $("#tagpresupuesto").val(presupuesto);
            });

            var miArray = new Array(${diagnosticos.getRowCount()});

    <c:forEach items="${diagnosticos.rowsByIndex}" var="item" varStatus="iter">
            miArray[${iter.index}] = "${item[2]} - ${item[0]}";
    </c:forEach> 
    <c:choose>
        <c:when test="${diagnosticosExistentes.getRowCount()==0}">
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
        </c:when>
        <c:otherwise>
                var miArrayEx = new Array(${diagnosticosExistentes.getRowCount()});
            <c:forEach items="${diagnosticosExistentes.rowsByIndex}" var="diagnostico" varStatus="iterD">
                    miArrayEx[${iterD.index}] = "${diagnostico[1]} - ${diagnostico[0]}";
            </c:forEach>
                    $(".tagManager").tagsManager({
                        prefilled: miArrayEx,
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
                
                    $("#formTrata input[name='hidden-tags2']").change();
                
        </c:otherwise>    
    </c:choose>
    <c:choose>
        <c:when test="${diagnosticosExistentes2.getRowCount()==0}">
                $(".tagManager5").tagsManager({
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
        </c:when>
        <c:otherwise>
                var miArrayEx5 = new Array(${diagnosticosExistentes5.getRowCount()});
            <c:forEach items="${diagnosticosExistentes5.rowsByIndex}" var="diagnostico5" varStatus="iterD5">
                    miArrayEx5[${iterD5.index}] = "${diagnostico5[1]} - ${diagnostico5[0]}";
            </c:forEach>
                    $(".tagManager5").tagsManager({
                        prefilled: miArrayEx5,
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
                
                    $("#formRadiografico input[name='hidden-tags5']").change();
                
        </c:otherwise>    
    </c:choose>
                
            $("#formDiag input[name='hidden-tags']").change(function() {

            });

            $("#datos2").validate({
                submitHandler: function() {
                    $.ajax({
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/formController?action=guardarDatosBasicos",
                        data: $("#datos2").serialize(),
                        success: function() {
                            $("a[href='#otro']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });

            $("#formPron").validate({
                submitHandler: function() {
                    $.ajax({
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/formController?action=guardarPron",
                        data: $("#formPron").serialize(),
                        success: function() {
                            // $("a[href='#otro']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });



            $("#datos3").validate({
                submitHandler: function() {
                    $.ajax({
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/formController?action=guardarDatosBasicos2",
                        data: $("#datos3").serialize(),
                        success: function() {
                            $("a[href='#diag']").click();
                        } //fin success
                    }); //fin $.ajax    
                }
            });


            $('#zonaeditar').change(function(e) {
                var str = "<i style='color:red'>";
                $("#zonaeditar option:selected").each(function() {
                    str += $(this).text() + "  ";
                })

                $("#zonaSeleccionada").html("Zona Seleccionada: " + str + " </i>");
            })

            $('#zonaeditar2').change(function(e) {

                var str2 = "<i style='color:red'>";
                $("#zonaeditar2 option:selected").each(function() {
                    str2 += $(this).text() + "  ";
                })

                $("#zonaSeleccionada2").html("Zona Seleccionada: " + str2 + " </i>");
            })

            $.reel.def.indicator = 5;

            $('.sample img[id]').each(function() {

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
        <li class="active"><a href="#profile" data-toggle="tab"> Datos basicos</a></li>
        <li ><a href="#otro" data-toggle="tab"> Examen Fis&iacute;co estomatologico</a></li>
        <li ><a href="#odontoIn" data-toggle="tab"> Dentici&oacute;n permanente</a></li>
        <li ><a href="#odontoFi" data-toggle="tab"> Dentici&oacute;n temporal</a></li>
        <li ><a href="#diag" data-toggle="tab"> Diagnostico y tratamiento </a></li>
        <li ><a href="#histo" data-toggle="tab"> H.C Endodoncia</a></li>
        <li ><a href="#radiografia" data-toggle="tab"> Radiograf&iacute;a</a></li>
        <li ><a href="#" data-toggle="tab"> <b>paciente: ${paciente.getRowsByIndex()[0][1]} - sexo:${paciente.getRowsByIndex()[0][5]}</b></a></li>
    </ul>





    <div id="myTabContent" class="tab-content">

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
                                    <th>Datos B&aacute;sicos</th>
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
                            <label for="ultima" class="control-label">Ultima Visita al odont&oacute;logo</label>
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



        <!-----------------PESTANA 2---------------------------->
        <div class="tab-pane fade" id="otro">

            <div class="span12">
                <form class="form-horizontal" id="datos3">
                    <fieldset>
                        <legend>III. Examen F&iacute;sico Estomatologico</legend>
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
                            <label for="tension" class="control-label">Tensi&oacute;n A.</label>
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
                                            <option selected="selected" value="Aveces">A veces</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Aveces">A veces</option>
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
                            <label class="control-label">Cuantas veces al d&iacute;a</label>
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
                                            <option selected="selected" value="Aveces">A veces</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Aveces">A veces</option>
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
                                            <option selected="selected" value="Aveces">A veces</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="Aveces">A veces</option>
                                        </c:otherwise>

                                    </c:choose>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">H&aacute;bitos y vicios</label>
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
                                <c:choose>
                                    <c:when test="${consulta.getRowsByIndex()[0][9]=='Bueno'}">
                                        <label class="radio inline">
                                            <input type="radio" value="Bueno" name="pronostico" class="{required:true}" checked>
                                            Bueno
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="radio inline">
                                            <input type="radio" value="Bueno" name="pronostico" class="{required:true}" >
                                            Bueno
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${consulta.getRowsByIndex()[0][9]=='Regular'}">
                                        <label class="radio inline">
                                            <input type="radio" value="Regular" name="pronostico" checked>
                                            Regular
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="radio inline">
                                            <input type="radio" value="Regular" name="pronostico" >
                                            Regular
                                        </label>
                                    </c:otherwise>
                                </c:choose>
                                <c:choose>
                                    <c:when test="${consulta.getRowsByIndex()[0][9]=='Malo'}">
                                        <label class="radio inline">
                                            <input type="radio" value="Malo" name="pronostico" checked>
                                            Malo
                                        </label>
                                    </c:when>
                                    <c:otherwise>
                                        <label class="radio inline">
                                            <input type="radio" value="Malo" name="pronostico" >
                                            Malo
                                        </label>
                                    </c:otherwise>
                                </c:choose>

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
                                        <c:set var="existe" value="false"></c:set>
                                        <c:forEach items="${interconsultaE.rowsByIndex}" var="intE" varStatus="staE">

                                            <c:choose>
                                                <c:when test="${intE[0]==row[0]}">
                                                    <c:set var="existe" value="true"></c:set>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${existe==true}">
                                                <label class="checkbox">
                                                    <input type="checkbox" value="${row[0]}" name="interconsulta${sta.index}" checked> ${row[1]}
                                                </label>

                                            </c:when>
                                            <c:otherwise>
                                                <label class="checkbox">
                                                    <input type="checkbox" value="${row[0]}" name="interconsulta${sta.index}"> ${row[1]}
                                                </label>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </fieldset> 
                            </div>

                            <div class="span3">
                                <fieldset>
                                    <legend>Plan de tratamiento</legend>  
                                    <c:forEach items="${planTratamiento.rowsByIndex}" var="row" varStatus="sta">
                                        <c:set var="existe2" value="false"></c:set>
                                        <c:forEach items="${planTratamientoE.rowsByIndex}" var="plE" varStatus="staP">

                                            <c:choose>
                                                <c:when test="${plE[0]==row[0]}">
                                                    <c:set var="existe2" value="true"></c:set>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${existe2==true}">
                                                <label class="checkbox">
                                                    <input type="checkbox" value="${row[0]}" name="plantratamiento${sta.index}" checked> ${row[1]}
                                                </label>

                                            </c:when>
                                            <c:otherwise>
                                                <label class="checkbox">
                                                    <input type="checkbox" value="${row[0]}" name="plantratamiento${sta.index}"> ${row[1]}
                                                </label>
                                            </c:otherwise>
                                        </c:choose>

                                    </c:forEach>

                                </fieldset> 
                            </div>
                            <div class="span3">
                                <fieldset>
                                    <legend>Remision</legend>  
                                    <c:forEach items="${remision.rowsByIndex}" var="row" varStatus="sta">
                                        <c:set var="existe3" value="false"></c:set>
                                        <c:forEach items="${remisionE.rowsByIndex}" var="remE" varStatus="staR">
                                            <c:choose>
                                                <c:when test="${remE[0]==row[0]}">
                                                    <c:set var="existe3" value="true"></c:set>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${existe3}">
                                                <label class="checkbox">
                                                    <input type="checkbox" value="${row[0]}" name="remision${sta.index}" checked> ${row[1]}
                                                </label>
                                            </c:when>
                                            <c:otherwise>
                                                <label class="checkbox">
                                                    <input type="checkbox" value="${row[0]}" name="remision${sta.index}"> ${row[1]}
                                                </label>
                                            </c:otherwise>
                                        </c:choose>                                        
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
                        <div class="input-prepend input-append" style="margin-left: 20px;">
                            <span class="add-on">$</span>
                            <input type="text" name="tagpresupuesto" id="tagpresupuesto"  value="0"/>
                        </div>
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
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" name="fechaE" id="fechaE" class="input-medium fecha" data-datepicker="datepicker"></td>
                                    <td><input type="text" name="reciboE" id="reciboE" class="input-medium"></td>
                                    <td><input type="text" name="tratamientoE" autocomplete="off" placeholder="Tratamiento" id="tratamientoE" class="tagManager3"/></td>
                                </tr>    
                            </tbody>
                        </table>

                        <button class="btn" type="button" id="agregarEvol">Agregar Evolucion</button>

                    </fieldset>
                </form>
            </div>
        </div>

        <!-----------------PESTANA 6---------------------------->
        <div class="tab-pane fade" id="histo">
            <div class="span12">
                <form class="form-horizontal" method="post" id="formAnte" action="">
                    <fieldset>
                        <legend>Antecedentes del caso y examen cl&iacute;nico</legend>
                        <div class="control-group">
                            <label class="control-label" for="eactual">Estado actual</label>
                            <div class="controls">
                                <textarea class="input-xxlarge {required:true}" name="eactual" id="eactual" rows="3">${historiaClinica.getRowsByIndex()[0][1]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label  class="control-label">Dolor</label>
                            <div class="span2"> 
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Provocado')}"> 
                                            <input type="checkbox" value="Provocado" name="dolor" checked="checked"> Provocado
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Provocado" name="dolor"> Provocado
                                        </c:otherwise>     
                                    </c:choose>

                                </label>
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Palpacion')}"> 
                                            <input type="checkbox" value="Palpacion" name="dolor" checked="checked"> Palpaci&oacute;n
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Palpacion" name="dolor"> Palpaci&oacute;n
                                        </c:otherwise>     
                                    </c:choose>

                                </label>
                            </div>
                            <div class="span2">
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Espontaneo')}"> 
                                            <input type="checkbox" value="Espontaneo" name="dolor" checked="checked"> Espont&aacute;neo
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Espontaneo" name="dolor"> Espont&aacute;neo
                                        </c:otherwise>     
                                    </c:choose>

                                </label>
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Percusion')}"> 
                                            <input type="checkbox" value="Percusion" name="dolor" checked="checked"> Percusi&oacute;n
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Percusion" name="dolor"> Percusi&oacute;n
                                        </c:otherwise>     
                                    </c:choose>

                                </label>
                            </div>
                            <div class="span2">
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Irradiado')}"> 
                                            <input type="checkbox" value="Irradiado" name="dolor" checked="checked"> Irradiado
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Irradiado" name="dolor"> Irradiado
                                        </c:otherwise>     
                                    </c:choose>

                                </label>
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Fistula')}"> 
                                            <input type="checkbox" value="Fistula" name="dolor" checked="checked"> Fistula
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Fistula" name="dolor"> Fistula
                                        </c:otherwise>     
                                    </c:choose>

                                </label>
                            </div>
                            <div class="span2">
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Localizado')}"> 
                                            <input type="checkbox" value="Localizado" name="dolor" checked="checked"> Localizado
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Localizado" name="dolor"> Localizado
                                        </c:otherwise>     
                                    </c:choose>
                                </label>
                                <label class="checkbox">
                                    <c:choose>
                                        <c:when test="${fn:contains(historiaClinica.getRowsByIndex()[0][2], 'Inflamacion')}"> 
                                            <input type="checkbox" value="Inflamacion" name="dolor" checked="checked"> Inflamaci&oacute;n
                                        </c:when>
                                        <c:otherwise>
                                            <input type="checkbox" value="Inflamacion" name="dolor"> Inflamaci&oacute;n
                                        </c:otherwise>     
                                    </c:choose>

                                </label>
                            </div>
                        </div>
                        <button autocomplete="off" data-loading-text="Guardando cambios..." data-original-title="Guardar cambios" id="guardarAnte" type="button" style="margin-top: 18px;margin-left: 20px;" class="btn">Guardar cambios</button>
                    </fieldset>
                </form>
                <form class="form-horizontal" method="post" id="formImpresion" action="">    
                    <fieldset>
                        <legend>Impresi&oacute;n clinica</legend>
                        <div class="control-group">
                            <label class="control-label" for="dienteI">Diente</label>
                            <div class="controls">
                                <textarea class="input-xxlarge {required:true}" name="dienteI" id="dienteI" rows="3">${historiaClinica.getRowsByIndex()[0][3]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="tejidos">Tejidos vecinos</label>
                            <div class="controls">
                                <textarea class="input-xxlarge {required:true}" name="tejidos" id="tejidos" rows="3">${historiaClinica.getRowsByIndex()[0][4]}</textarea>
                            </div>
                        </div>
                        <button autocomplete="off" data-loading-text="Guardando cambios..." data-original-title="Guardar cambios" id="guardarImpresion" type="button" style="margin-top: 18px;margin-left: 20px;" class="btn">Guardar cambios</button>
                    </fieldset>
                </form>
                <form class="form-horizontal" method="post" id="formVitalometrica" action="">   
                    <fieldset>
                        <legend>Pruebas vitalom&eacute;tricas</legend>
                        <div class="control-group">
                            <label class="control-label" for="frio">T&eacute;rmicas - frio</label>
                            <div class="controls">
                                <textarea class="input-xxlarge {required:true}" name="frio" id="frio" rows="3">${historiaClinica.getRowsByIndex()[0][5]}</textarea>
                            </div>
                        </div>
                        <button autocomplete="off" data-loading-text="Guardando cambios..." data-original-title="Guardar cambios" id="guardarVitalometrica" type="button" style="margin-top: 18px;margin-left: 20px;" class="btn">Guardar cambios</button>
                    </fieldset>
                </form>
                <form id="formRadiografico"  method="POST">
                    <fieldset>
                        <legend>Examen radiogr&aacute;fico</legend>
                        <div class="control-group">
                            <label class="control-label" for="corona">Imagen radiogr&aacute;fica de la corona</label>
                            <div class="controls">
                                <textarea class="input-xxlarge" name="corona" id="corona" rows="3">${historiaClinica.getRowsByIndex()[0][10]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="raiz">Imagen radiogr&aacute;fica de la ra&iacute;z</label>
                            <div class="controls">
                                <textarea class="input-xxlarge" name="raiz" id="raiz" rows="3">${historiaClinica.getRowsByIndex()[0][11]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="periapical">Imagen radiogr&aacute;fica regi&oacute;n periapical</label>
                            <div class="controls">
                                <textarea class="input-xxlarge" name="periapical" id="periapical" rows="3">${historiaClinica.getRowsByIndex()[0][12]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="evaluacion">Evaluaciones del tratamiento endod&oacute;ntico</label>
                            <div class="controls">
                                <textarea class="input-xxlarge" name="evaluacion" id="evaluacion" rows="3">${historiaClinica.getRowsByIndex()[0][6]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="ObservacionesE">Observaciones</label>
                            <div class="controls">
                                <textarea class="input-xxlarge {required:true}" name="ObservacionesE" id="ObservacionesE" rows="3">${historiaClinica.getRowsByIndex()[0][7]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="etiologia">Etiolog&iacute;a</label>
                            <div class="controls">
                                <textarea class="input-xxlarge {required:true}" name="etiologia" id="etiologia" rows="3">${historiaClinica.getRowsByIndex()[0][8]}</textarea>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="diagnosticoE">Diagn&oacute;stico</label>
                            <div class="controls">
                                <input type="text" name="tags5" autocomplete="off" placeholder="Diagnostico" class="tagManager5"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="tratamientoE">Tratamiento</label>
                            <div class="controls">
                                <input type="text" name="tags6" autocomplete="off" placeholder="Tratamiento" class="tagManager6"/>
                            </div>
                        </div>
                        <button autocomplete="off" data-loading-text="Guardando cambios..." data-original-title="Guardar cambios" id="guardarRadiografico" type="button" style="margin-top: 18px;margin-left: 20px;" class="btn">Guardar cambios</button>                        
                    </fieldset>
                </form>
                <form  id="formPreparacion"  method="POST">
                    <fieldset>
                        <legend>Preparaci&oacute;n biom&eacute;dica</legend>
                        <table class="table table-striped" id="tablaPre">
                            <thead>
                                <tr>
                                    <th>Canal</th>
                                    <th>Referencia</th>
                                    <th>L.A (mm)</th>
                                    <th>L.R.I (mm)</th>
                                    <th>L.R.T (mm)</th>
                                    <th>Inst Inicial</th>
                                    <th>Lima retroceso</th>
                                    <th>Prepaci&oacute;n apical</th>
                                    <th>Acci&oacute;n</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${preparacionBiomedica.rowsByIndex}" var="preparacion" varStatus="status">
                                    <tr>
                                        <td>${preparacion[1]}</td>
                                        <td>${preparacion[2]}</td>
                                        <td>${preparacion[3]}</td>
                                        <td>${preparacion[4]}</td>
                                        <td>${preparacion[5]}</td>
                                        <td>${preparacion[6]}</td>
                                        <td>${preparacion[7]}</td>
                                        <td>${preparacion[8]}</td>
                                        <td class="action icon16">
                                            <a class="icon-remove eliminarPreparacion" href="#eliminarPreparacion?pid=${preparacion[0]}" title="Eliminar"></a>
                                        </td>
                                    </tr>                                    
                                </c:forEach>
                                <tr>
                                    <td><input type="text" value="" name="canalete" id="canalete" class="input-small"/></td>
                                    <td><input type="text" value="" name="referencia" id="referencia" class="input-small"/></td>
                                    <td><select name="la" id="la" class="input-small">
                                            <c:forEach var="numero" items="10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30">
                                                <option value="${numero}">${numero}</option>    
                                            </c:forEach>
                                        </select>
                                    </td>
                                    <td><select name="lri" id="lri" class="input-small">
                                            <c:forEach var="numero2" items="10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30">
                                                <option value="${numero2}">${numero2}</option>    
                                            </c:forEach>
                                        </select></td>
                                    <td><select name="lrt" id="lrt" class="input-small">
                                            <c:forEach var="numero3" items="10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30">
                                                <option value="${numero3}">${numero3}</option>    
                                            </c:forEach>
                                        </select></td>
                                    <td><select name="inst" id="inst" class="input-small">
                                            <option value="15">L# 15</option>    
                                            <option value="20">L# 20</option>    
                                            <option value="25">L# 25</option>    
                                            <option value="30">L# 30</option>    
                                            <option value="35">L# 35</option>    
                                            <option value="40">L# 40</option>    
                                            <option value="45">L# 45</option>    
                                            <option value="50">L# 50</option>    
                                            <option value="60">L# 60</option>    
                                            <option value="70">L# 70</option>    
                                            <option value="80">L# 80</option>    
                                        </select></td>
                                    <td><input type="text" value="" name="lima" id="lima" class="input-small"/></td>
                                    <td><input type="text" value="" name="preparacion" id="preparacion" class="input-small"/></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                        <button autocomplete="off" data-loading-text="Guardando cambios..." data-original-title="Agregar preparaci&oacute;n biom&eacute;dica" id="agregarPreparacion" type="button" style="margin-top: 18px;margin-left: 20px;" class="btn">Agregar preparaci&oacute;n biom&eacute;dica</button>                        
                    </fieldset>
                </form>
                <form id="formControl" method="post" class="form-horizontal">
                    <fieldset>
                        <legend>Control de tratamiento</legend>
                        <table id="controles" class="table table-striped">
                            <thead>
                                <tr>
                                    <th>fecha</th>
                                    <th>tratamientos realizados</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="idActual" value="${controles.getRowsByIndex()[0][0]}"></c:set>
                                <c:set var="tratamientos" value=""></c:set>

                                <%--  <c:forEach items="${controles.rowsByIndex}" var="control" varStatus="status">
                                      <c:choose>
                                          <c:when test="${idActual==control[0]}">
                                              <c:set var="tratamientos" value="${tratamientos} + ',' +${controles[2]}"></c:set>            
                                          </c:when>
                                          <c:otherwise>
                                              <tr>
                                                  <td>${idActual}</td>
                                                  <td>${tratamientos}</td>
                                                  <td class="action icon16">
                                                      <a class="icon-remove eliminarControl" href="#eliminarControl?pid=${idActual}" title="Eliminar"></a>
                                                  </td>
                                              </tr> 
                                              <c:set var="idActual" value="${control[0]}"></c:set>
                                              <c:set var="tratamientos" value="${control[2]}"></c:set> 
                                          </c:otherwise>
                                      </c:choose>

                                </c:forEach>--%>
                                <tr>
                                    <td><input type="text" name="fechaTrat10" id="fechaTrat10" class="input-medium fecha" data-datepicker="datepicker"></td>
                                    <td><input type="text" name="tags10" autocomplete="off" id="tratamientoR10" placeholder="Tratamiento realizado" class="tagManager10"/></td>
                                </tr>
                            </tbody>
                        </table>
                        <button autocomplete="off" data-loading-text="Guardando cambios..." data-original-title="Agregar control de tratamiento" id="agregarControl" type="button" style="margin-top: 18px;margin-left: 20px;" class="btn">Agregar control de tratamiento</button>                        
                    </fieldset>
                </form>
            </div>
        </div>



        <!-----------------PESTANA 7---------------------------->
        <div class="tab-pane fade" id="radiografia">
            <div class="row" style="width: 900px;">
                <div class="span2" style="margin-left:20px;">
                    <svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                         width="123.515px" height="240px" viewBox="0 240 123.515 240" enable-background="new 0 240 123.515 240" xml:space="preserve">

                    <image overflow="visible" width="256" height="480" xlink:href="<%=request.getContextPath()%>/images/adultos.gif"  transform="matrix(0.5 0 0 0.499 -0.5 239.9998)">
                    </image>
                    <g id="Layer_1">
                    <path id="21" fill="transparent" class="mini" d="M61.25,255.717c-1,0-2,0-3,0c-0.776-3.646-3.799-5.008-4-9.479c2.419-1.271,4.543-1.994,8.5-1.996
                          c0.438,1.155,0.509,2.199,0.5,3.991c-1.104,1.253-0.351,3.729-1,5.489c-0.167,0-0.333,0-0.5,0
                          C61.583,254.386,61.417,255.052,61.25,255.717z"/>
                    <path id="11" fill="transparent" class="mini" d="M65.75,244.241c3.469-0.077,5.684,0.527,8,1.497c0.167,0.499,0.333,0.998,0.5,1.497c-0.167,0-0.333,0-0.5,0
                          c0,0.665,0,1.33,0,1.995c-0.167,0-0.333,0-0.5,0c-0.167,0.499-0.333,0.998-0.5,1.497c-0.333,0.166-0.667,0.333-1,0.499
                          c0,0.665,0,1.331,0,1.996c-0.333,0.166-0.667,0.333-1,0.499c-1.113,1.183-1.05,1.466-3.5,1.496c-0.706-1.328-1.015-2.105-1-4.49
                          c-0.167,0-0.333,0-0.5,0c-0.167-1.996-0.333-3.991-0.5-5.987c0.167,0,0.333,0,0.5,0C65.75,244.574,65.75,244.407,65.75,244.241z"/>
                    <path id="22" fill="transparent" class="mini" d="M50.25,248.232c0.667,0,1.333,0,2,0c0.167,0.499,0.333,0.998,0.5,1.497c1,0.99,1.965,4.84,2,6.985
                          c-1.561,0.906-1.693,1.488-4.5,1.497c-1.542-2.59-4.285-2.948-4.5-6.985c0.667-0.499,1.333-0.998,2-1.497c0-0.166,0-0.333,0-0.499
                          C48.864,248.579,49.146,249.503,50.25,248.232z"/>
                    <path id="12" fill="transparent" class="mini" d="M75.75,248.232c1.333,0.167,2.667,0.333,4,0.499c1.247,1.837,2.823,1.332,3,4.491
                          c-0.5,0.333-1,0.665-1.5,0.998c0,0.332,0,0.665,0,0.997c-1.167,0.832-2.333,1.663-3.5,2.495c0,0.166,0,0.333,0,0.499
                          c-0.667,0-1.333,0-2,0c-0.368-0.702-0.898-1.508-1.5-1.996c0-1.496,0-2.993,0-4.49C74.613,250.618,75.432,249.62,75.75,248.232z"/>
                    <path id="23" fill="transparent" class="mini" d="M40.25,263.201c-0.293-1.116-0.418-1.25-1-1.995c-0.167,0-0.333,0-0.5,0c0-0.333,0-0.665,0-0.998
                          c-0.333-0.166-0.667-0.333-1-0.499c-0.167-1.497-0.333-2.994-0.5-4.491c0.5-0.166,1-0.332,1.5-0.498
                          c1.025-0.94,4.612-0.549,6.5-0.499c0.333,0.499,0.667,0.997,1,1.496c0.167,0,0.333,0,0.5,0c1.018,1.588,1.01,4.36,1,6.985
                          c-2.036,1.181-1.877,1.534-5.5,1.497C41.622,263.247,41.743,263.372,40.25,263.201z"/>
                    <path id="13" fill="transparent" class="mini" d="M83.75,254.22c2,0,4,0,6,0c0,0.166,0,0.332,0,0.499c0.167,0,0.333,0,0.5,0c0.167,1.663,0.333,3.326,0.5,4.989
                          c-0.826,0.666-1.252,1.748-2,2.495c-0.749,0.746-1.829,1.173-2.5,1.995c-1.333,0-2.667,0-4,0c-0.792-1.362-1.371-1.22-1.5-3.492
                          c0.167,0,0.333,0,0.5,0c0-1.331,0-2.661,0-3.992c0.167,0,0.333,0,0.5,0C82.417,255.884,83.083,255.052,83.75,254.22z"/>
                    <path id="24" fill="transparent" class="mini" d="M35.75,262.204c0.667,0,1.333,0,2,0c0.919,1.283,2.923,1.938,3.5,3.492c0.984,2.652-1.461,8.972-2.5,9.48
                          c-1,0-2,0-3,0c-2.167-1.331-4.333-2.661-6.5-3.992c0-0.998,0-1.995,0-2.993c0.5-0.333,1-0.665,1.5-0.998c0-0.333,0-0.665,0-0.998
                          c0.833-0.665,1.667-1.331,2.5-1.996c0.167-0.332,0.333-0.665,0.5-0.998C34.584,262.625,34.893,263.204,35.75,262.204z"/>
                    <path id="14" fill="transparent" class="mini" d="M90.75,262.204c0.833,0,1.667,0,2.5,0c2.181,3.276,5.871,3.184,6,8.98c-2.973,1.685-4.769,3.914-9.5,3.992
                          c-1.254-2.811-2.457-4.743-2.5-8.981c0.167,0,0.333,0,0.5,0c0-0.499,0-0.998,0-1.497C88.364,263.718,90.021,263.328,90.75,262.204z
                          "/>
                    <path id="25" fill="transparent" class="mini" d="M27.25,273.18c1.5,0.333,3,0.665,4.5,0.998c0.833,0.998,1.667,1.996,2.5,2.994c0.167,0,0.333,0,0.5,0
                          c0.578,0.831-0.008,1.143,1,1.995c0.215,5.207-0.256,9.094-5.5,8.981c0-0.166,0-0.333,0-0.499c-0.833-0.166-1.667-0.333-2.5-0.499
                          c0-0.166,0-0.333,0-0.499c-0.333,0-0.667,0-1,0c-0.333-0.499-0.667-0.998-1-1.497c-0.333,0-0.667,0-1,0
                          c-0.167-0.332-0.333-0.665-0.5-0.997c-1.814-1.773-1.558-1.403-1.5-4.99c0.167,0,0.333,0,0.5,0c0.167-0.998,0.333-1.995,0.5-2.993
                          C24.917,275.177,26.083,274.178,27.25,273.18z"/>
                    <path id="15" fill="transparent" class="mini" d="M105.25,284.158c-1.119,0.288-1.257,0.416-2,0.997c0,0.167,0,0.333,0,0.499c-0.333,0-0.667,0-1,0
                          c-0.167,0.333-0.333,0.665-0.5,0.998c-0.333,0-0.667,0-1,0c-1.646,0.846-2.921,1.406-5.5,1.497c-0.982-1.764-1.926-2.098-2-4.989
                          c-0.167,0-0.333,0-0.5,0c0-1.331,0-2.661,0-3.992c0.167,0,0.333,0,0.5,0c0.455-2.054,4.751-7.145,8-5.987c0,0.166,0,0.333,0,0.499
                          c0.333,0,0.667,0,1,0c0.333,0.499,0.667,0.998,1,1.497c0.167,0,0.333,0,0.5,0c0,0.499,0,0.998,0,1.497c0.5,0.332,1,0.665,1.5,0.997
                          c0.167,1.83,0.333,3.659,0.5,5.489C105.181,283.728,105.551,283.161,105.25,284.158z"/>
                    <path id="26" fill="transparent" class="mini" d="M23.75,305.114c0-0.333,0-0.665,0-0.998c-1.769-0.143-2.442-0.673-4-0.998c-0.264-0.458-1.5-1.497-1.5-1.497
                          c0-2.827,0-5.655,0-8.482c0.167,0,0.333,0,0.5,0c0-0.665,0-1.33,0-1.995c0.167,0,0.333,0,0.5,0c0-0.333,0-0.665,0-0.998
                          c0.544-1.008,1.567-1.831,2.5-2.495c0-0.166,0-0.333,0-0.499c1.5,0,3,0,4.5,0c1.636,1.837,4.191,2.234,5.5,4.491
                          c2.434,2.329,0.043,8.364-0.5,10.977c-0.824,0.493-2.167,2.337-2.5,2.495C27.083,305.114,25.417,305.114,23.75,305.114z"/>
                    <path id="16" fill="transparent" class="mini" d="M102.25,287.151c1.5,0,3,0,4.5,0c0.779,1.337,2.405,2.505,3,3.992c1.063,2.659,0.507,7.07,0.5,10.478
                          c-0.5,0.333-1,0.665-1.5,0.998c0,0.166,0,0.333,0,0.499c-1.461,0.956-6.611,1.93-9,1.996c-0.5-0.665-1-1.331-1.5-1.996
                          c-0.167,0-0.333,0-0.5,0c-0.167-1.164-0.333-2.328-0.5-3.492c-0.333-0.167-0.667-0.333-1-0.499c-0.167-1.996-0.333-3.992-0.5-5.988
                          c0.167,0,0.333,0,0.5,0c0-0.499,0-0.997,0-1.496c0.167,0,0.333,0,0.5,0c0.833-0.998,1.667-1.996,2.5-2.994c0.333,0,0.667,0,1,0
                          c0-0.166,0-0.333,0-0.499C101.252,287.578,101.465,288.054,102.25,287.151z"/>
                    <path id="27" fill="transparent" class="mini" d="M14.25,318.087c-0.167-1.331-0.333-2.661-0.5-3.991c0.167,0,0.333,0,0.5,0c0.167-2.162,0.333-4.325,0.5-6.487
                          c2.864-1.715,1.309-2.536,6.5-2.494c0,0.166,0,0.333,0,0.499c1,0.166,2,0.333,3,0.499c0,0.166,0,0.332,0,0.499
                          c0.667,0.166,1.333,0.332,2,0.499c0,0.166,0,0.332,0,0.498c0.833,0.666,1.667,1.331,2.5,1.996c0,0.998,0,1.996,0,2.994
                          c1.226,1.311,0.137,4.747,0,6.486c-2.473,1.482-1.569,2.511-6,2.495c-1.079-0.936-2.903,0.107-4.5-0.499c0-0.166,0-0.333,0-0.499
                          c-0.333,0-0.667,0-1,0c0-0.166,0-0.333,0-0.499C16.202,319.26,15.744,318.492,14.25,318.087z"/>
                    <path id="17" fill="transparent" class="mini" d="M107.25,305.114c1.5,0,3,0,4.5,0c0.391,0.715,1.386,2.002,2,2.494c0.131,2.263,1.38,5.733,0.5,8.482
                          c-0.167,0-0.333,0-0.5,0c-0.167,0.832-0.333,1.663-0.5,2.495c-0.667,0.499-1.333,0.998-2,1.497c0,0.166,0,0.333,0,0.499
                          c-1.744,1.11-6.121,1.009-9,0.998c-1.055-1.758-2.331-1.662-2.5-4.491c-0.167,0-0.333,0-0.5,0c0.167-2.328,0.333-4.657,0.5-6.985
                          c0.167,0,0.333,0,0.5,0c0.527-1.951,1.424-2.099,3-2.993c0-0.167,0-0.333,0-0.499c0.333,0,0.667,0,1,0c0-0.167,0-0.333,0-0.499
                          c1-0.166,2-0.333,3-0.499C107.25,305.447,107.25,305.28,107.25,305.114z"/>
                    <path id="28" fill="transparent" class="mini" d="M26.75,336.05c-0.5,0.166-1,0.332-1.5,0.499c0,0.166,0,0.332,0,0.499c-0.5,0-1,0-1.5,0
                          c-0.167,0.332-0.333,0.665-0.5,0.997c-1.687,0.713-6.421-0.447-7-0.997c-2.037-0.469-2.083-1.464-2-3.992
                          c-0.523-0.533-0.978-3.714-0.5-4.989c0.167,0,0.333,0,0.5,0c0-0.333,0-0.665,0-0.998c0.167,0,0.333,0,0.5,0
                          c0-0.499,0-0.998,0-1.497c0.167,0,0.333,0,0.5,0c0-0.333,0-0.665,0-0.998c0.167,0,0.333,0,0.5,0c0-0.333,0-0.665,0-0.998
                          c0.167,0,0.333,0,0.5,0c0.667-0.744,0.246-0.693,1.5-0.998c1.207-1.118,4.109-0.107,6,0c1.05,1.543,0.715,0.216,2,0.998
                          c0.833,0.998,1.667,1.996,2.5,2.994c0.061,1.705,0.728,5.955,0,7.484c-0.167,0-0.333,0-0.5,0
                          C27.204,334.875,27.067,334.892,26.75,336.05z"/>
                    <path id="18" fill="transparent" class="mini" d="M101.75,336.05c-0.315-1.13-0.428-1.219-1-1.996c-0.167,0-0.333,0-0.5,0c0-0.333,0-0.665,0-0.998
                          c-0.167,0-0.333,0-0.5,0c-0.21-0.839,0.477-0.887,0.5-0.998c0.436-2.104,0.184-4.794,0.5-6.486c1.333-0.998,2.667-1.996,4-2.994
                          c2.747-0.153,4.356-0.486,7,0c0.833,1.164,1.667,2.329,2.5,3.493c0,0.499,0,0.998,0,1.497c0.167,0,0.333,0,0.5,0
                          c-0.167,2.827-0.333,5.655-0.5,8.482c-0.9,0.471-0.787,0.691-2,0.998c-0.64,0.657-4.682,1.699-6.5,0.997c0-0.166,0-0.332,0-0.499
                          c-0.333,0-0.667,0-1,0c0-0.166,0-0.332,0-0.498C103.728,336.292,103.549,336.216,101.75,336.05z"/>
                    <path id="38" fill="transparent" class="mini" d="M14.25,386.444c0.333,0,0.667,0,1,0c0.167-0.333,0.333-0.665,0.5-0.998c1.833,0,3.667,0,5.5,0
                          c1.218,1.934,3.706,3.225,4.5,5.488c1.284,3.661-2.123,6.328-4,6.985c-1.59,0.558-3.446-0.287-4.5-0.499
                          c-0.333-0.498-0.667-0.997-1-1.496c-0.167,0-0.333,0-0.5,0C14.216,393.594,14.24,390.332,14.25,386.444z"/>
                    <path id="48" fill="transparent" class="mini" d="M106.75,385.446c2,0,4,0,6,0c1.165,2.209,1.043,3.529,1,6.985c-0.167,0-0.333,0-0.5,0c0,0.499,0,0.998,0,1.497
                          c-1.424,2.902-2.54,4.054-7,3.991c0-0.166,0-0.332,0-0.499c-0.5,0-1,0-1.5,0c0-0.166,0-0.332,0-0.498
                          c-1.037-0.814-1.6-0.963-2-2.495c-0.167,0-0.333,0-0.5,0c0-1.164,0-2.329,0-3.493c1-0.858,0.421-1.158,1-1.995
                          c0.333-0.167,0.667-0.333,1-0.499C105.083,387.442,105.917,386.444,106.75,385.446z"/>
                    <path id="37" fill="transparent" class="mini" d="M20.75,398.419c1.913-0.019,3.136,0.239,4.5,0.499c0.327,0.59,0.811,0.712,1,0.998c0,0.333,0,0.665,0,0.998
                          c0.333,0.166,0.667,0.333,1,0.499c1.211,2.316,0.984,7.354,0.5,9.979c-3.389,2.016-1.868,3.521-8,3.492
                          c-0.333-0.499-0.667-0.998-1-1.497c-0.167,0-0.333,0-0.5,0c0-0.332,0-0.665,0-0.998c-0.167,0-0.333,0-0.5,0c0-0.665,0-1.33,0-1.995
                          c-1.212-3.594-1.49-6.84,0-10.479c0.503-0.246,0.917-0.955,1-0.998c0.667,0,1.333,0,2,0C20.75,398.752,20.75,398.585,20.75,398.419
                          z"/>
                    <path id="47" fill="transparent" class="mini" d="M103.25,398.419c3.334-0.12,5.802-0.022,7,1.996c2.58,2.481,0.074,10.328-0.5,12.973
                          c-2.036,1.181-1.877,1.533-5.5,1.497c-1.036-1.597-2.242-1.138-3.5-1.497c-0.167-0.499-0.333-0.998-0.5-1.496
                          c-0.167,0-0.333,0-0.5,0c0-0.499,0-0.998,0-1.497c-0.167,0-0.333,0-0.5,0c0.5-2.993,1-5.988,1.5-8.981c0.5-0.333,1-0.665,1.5-0.998
                          c0-0.333,0-0.665,0-0.998C102.46,399.107,102.912,399.021,103.25,398.419z"/>
                    <path id="36" fill="transparent" class="mini" d="M32.25,417.879c0.606,2.898,3.316,9.291,0,11.476c0,0.166,0,0.333,0,0.499c-0.667,0-1.333,0-2,0
                          c-0.167,0.333-0.333,0.665-0.5,0.998c-1.14,0.9-2.391,0.992-4.5,0.998c-0.333-0.499-0.667-0.998-1-1.497c-0.167,0-0.333,0-0.5,0
                          c-0.167-0.665-0.333-1.331-0.5-1.996c-0.333-0.166-0.667-0.332-1-0.499c0-0.665,0-1.33,0-1.995c-1.035-2.983-1.593-5.102-1-8.482
                          c2.368-1.058,4.391-1.947,8-1.996c0.351,0.705,0.72,0.612,1,0.998c0,0.333,0,0.665,0,0.998
                          C30.727,417.926,31.27,417.764,32.25,417.879z"/>
                    <path id="46" fill="transparent" class="mini" d="M98.25,415.384c3.771-0.155,7.753,0.265,8.5,2.994c0.167,0,0.333,0,0.5,0c-0.167,1.995-0.333,3.991-0.5,5.987
                          c-0.167,0-0.333,0-0.5,0c0,0.499,0,0.998,0,1.497c-0.167,0-0.333,0-0.5,0c0,0.499,0,0.998,0,1.496c-0.167,0-0.333,0-0.5,0
                          c0,0.499,0,0.998,0,1.497c-0.333,0.166-0.667,0.333-1,0.499c0,0.333,0,0.665,0,0.998c-0.5,0.333-1,0.665-1.5,0.998
                          c0,0.166,0,0.333,0,0.499c-1,0-2,0-3,0c-1.291-1.912-3.805-1.899-4.5-4.491c-0.167,0-0.333,0-0.5,0c0.333-2.66,0.667-5.322,1-7.982
                          c0.333-0.167,0.667-0.333,1-0.499c0.167-0.832,0.333-1.664,0.5-2.495c0.333,0,0.667,0,1,0
                          C98.25,416.049,98.25,415.717,98.25,415.384z"/>
                    <path id="35" fill="transparent" class="mini" d="M30.25,432.348c1,0,2,0,3,0c0.305,0.575,0.853,0.759,1,0.998c0,0.332,0,0.665,0,0.998c0.167,0,0.333,0,0.5,0
                          c0.167,0.997,0.333,1.995,0.5,2.993c0.167,0,0.333,0,0.5,0c0,0.665,0,1.331,0,1.996c0.167,0,0.333,0,0.5,0c0,0.333,0,0.665,0,0.998
                          c0.167,0,0.333,0,0.5,0c0,0.998,0,1.995,0,2.993c-2.735,2.361-2.033,3.924-7,2.994c-0.333-0.499-0.667-0.998-1-1.497
                          c-0.167,0-0.333,0-0.5,0c-0.898-1.398-2.717-8.104-1.5-9.979C27.917,434.011,29.083,433.179,30.25,432.348z"/>
                    <path id="45" fill="transparent" class="mini" d="M94.75,432.348c1,0,2,0,3,0c0,0.166,0,0.333,0,0.499c0.333,0,0.667,0,1,0c0.833,0.998,1.667,1.995,2.5,2.993
                          c0.167,0,0.333,0,0.5,0c0,1.33,0,2.662,0,3.992c-0.167,0-0.333,0-0.5,0c-0.167,0.998-0.333,1.996-0.5,2.993
                          c-1.603,3.522-3.499,4.68-7.5,2.994c-0.968-2.31-1.501-2.941-1.5-6.486c0.167,0,0.333,0,0.5,0c0.167-1.164,0.333-2.329,0.5-3.493
                          c0.167,0,0.333,0,0.5,0C93.873,434.559,94.214,433.522,94.75,432.348z"/>
                    <path id="34" fill="transparent" class="mini" d="M38.25,444.323c0.5,0,1,0,1.5,0c0.351,0.579,1.428,1.366,1.5,1.497c0.167,0.998,0.333,1.996,0.5,2.994
                          c0.167,0,0.333,0,0.5,0c0,0.332,0,0.665,0,0.997c0.167,0,0.333,0,0.5,0c0.849,2.328,0.055,7.213-1.5,7.983c-1,0-2,0-3,0
                          c-1.305-2.089-7.634-5.906-5-9.979c0.167,0,0.333,0,0.5,0C35.065,446.186,36.979,445.813,38.25,444.323z"/>
                    <path id="44" fill="transparent" class="mini" d="M88.25,444.323c0.5,0,1,0,1.5,0c0,0.166,0,0.333,0,0.499c2.575,0.563,5.493,3.183,5.5,6.486
                          c-0.999,0.86-0.422,1.159-1,1.996c-1.833,1.663-3.667,3.327-5.5,4.989c-2.713-1.036-3.912-2.364-4-5.987
                          c0.884-1.006,0.415-2.695,1-3.991c0.167,0,0.333,0,0.5,0c0-0.333,0-0.665,0-0.998c0.333-0.166,0.667-0.333,1-0.499
                          c0-0.333,0-0.665,0-0.998c0.167,0,0.333,0,0.5,0C87.917,445.321,88.083,444.822,88.25,444.323z"/>
                    <path id="33" fill="transparent" class="mini" d="M42.75,456.798c2.829-0.654,2.613-1.186,5.5,0c0.667,1.781,0.523,4.945,0.5,7.484
                          c-0.569,0.568-0.199,0.002-0.5,0.997c-1.219,0.459-3.097,0.518-5,0.499c-0.167-0.499-0.333-0.998-0.5-1.496
                          c-0.991-0.946-0.012-0.261-0.5-1.497C41.204,460.134,42.411,459.299,42.75,456.798z"/>
                    <path id="43" fill="transparent" class="mini" d="M85.25,456.798c0.167,0.665,0.333,1.331,0.5,1.995c0.167,0,0.333,0,0.5,0c0.853,2.475-0.659,4.838-1,6.486
                          c-1.219,0.459-3.097,0.518-5,0.499c-0.167-0.499-0.333-0.998-0.5-1.496c-1.044-1.141-0.551-5.431-0.5-7.484
                          c0.567-0.422,0.073,0.063,0.5-0.499c1.167-0.166,2.333-0.333,3.5-0.499C83.833,456.478,84.162,456.562,85.25,456.798z"/>
                    <path id="32" fill="transparent" class="mini" d="M54.25,471.766c-0.667,0-1.333,0-2,0c-1.41-2.079-3.296-1.395-3.5-4.99c1.182-0.988,1.68-2.64,3-3.492
                          c0-0.166,0-0.333,0-0.499c0.833-0.166,1.667-0.333,2.5-0.499c0,0.166,0,0.333,0,0.499C56.582,464.776,54.462,469.124,54.25,471.766
                          z"/>
                    <path id="42" fill="transparent" class="mini" d="M73.75,471.766c0-0.665,0-1.331,0-1.996c-0.333,0-0.667,0-1,0c0-2.162,0-4.324,0-6.486
                          c0.934-0.353,1.955-0.495,3.5-0.499c1.176,2.125,2.822,2.771,3,5.987C77.271,469.939,76.871,471.578,73.75,471.766z"/>
                    <path id="31" fill="transparent" class="mini" d="M62.75,474.76c-1.833,0-3.667,0-5.5,0c-0.167-0.499-0.333-0.998-0.5-1.497c-0.903-0.961-0.484-2.883,0-3.991
                          c0.167,0,0.333,0,0.5,0c0.167-0.998,0.333-1.996,0.5-2.994c1.039-0.546,0.886-0.803,2.5-0.998c0.305,0.563,0.856,0.766,1,0.998
                          c0,0.334,0,0.666,0,0.998c0.167,0,0.333,0,0.5,0c0,0.499,0,0.998,0,1.497c0.167,0,0.333,0,0.5,0c0,0.333,0,0.666,0,0.998
                          c0.167,0,0.333,0,0.5,0C62.75,471.433,62.75,473.097,62.75,474.76z"/>
                    <path id="41" fill="transparent" class="mini" d="M66.75,465.778c0.833-0.165,1.667-0.332,2.5-0.499c0.422,0.567-0.063,0.073,0.5,0.499
                          c0.207,2.651,1.468,4.664,2,6.985c-0.5,0.334-1,0.666-1.5,0.998c-0.871,0.9-2.197,0.996-4,0.998c-0.353-0.931-0.497-1.95-0.5-3.492
                          c0.167,0,0.333,0,0.5,0c0-1.497,0-2.994,0-4.491C66.25,466.776,66.596,466.694,66.75,465.778z"/>
                    </g>
                    </svg>

                    <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                         width="125.997px" height="200px" viewBox="12.999 20 125.997 200" enable-background="new 12.999 20 125.997 200"
                         xml:space="preserve">
                    <g id="Layer_2">

                    <image overflow="visible" enable-background="new    " width="302" height="480" xlink:href="<%=request.getContextPath()%>/images/ninos.gif"  transform="matrix(0.4172 0 0 0.4167 12.9985 19.9995)">
                    </image>
                    </g>
                    <g id="Layer_1_1_">
                    <g>
                    <path id="51" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M64.159,27c2.902-0.091,8.341,0.387,9.589,1.67
                          c0.475,0.476,0.166,0.002,0.417,0.834c0.526,0.552,0.8,3.794,0.417,5.009c-0.139,0-0.278,0-0.417,0c0,0.557,0,1.113,0,1.67
                          c-0.138,0-0.277,0-0.417,0c-0.138,0.834-0.277,1.669-0.417,2.505c-0.139,0-0.278,0-0.417,0c-0.695,0.834-1.389,1.67-2.083,2.504
                          c-0.974,0-1.947,0-2.919,0c-0.741-0.824-0.891-0.346-1.668-0.834c-0.139-0.278-0.277-0.557-0.417-0.835c-0.416,0-0.834,0-1.25,0
                          c-0.279-0.417-0.556-0.834-0.834-1.252c-0.278,0-0.555,0-0.834,0c-0.556-0.696-1.111-1.392-1.668-2.088c-0.278,0-0.555,0-0.834,0
                          c0-0.139,0-0.278,0-0.417c-0.416-0.277-0.833-0.557-1.25-0.834c0-0.278,0-0.557,0-0.834c-0.278-0.139-0.556-0.278-0.834-0.417
                          c0-1.113,0-2.226,0-3.339c0.695-0.557,1.39-1.113,2.085-1.669c0-0.139,0-0.279,0-0.418c0.695,0,1.391,0,2.085,0
                          c0.139-0.278,0.278-0.557,0.417-0.835c0.417,0,0.834,0,1.25,0C64.159,27.279,64.159,27.14,64.159,27z"/>
                    <path id="61" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M89.591,29.922
                          c1.462,0.221,2.112,0.261,2.504,1.67c0.137,0,0.276,0,0.416,0c0,0.696,0,1.392,0,2.087c-1.112,0.974-2.225,1.948-3.336,2.922
                          c-0.14,0.278-0.278,0.557-0.418,0.834c-0.278,0-0.556,0-0.835,0c-0.138,0.278-0.276,0.557-0.416,0.835c-0.276,0-0.556,0-0.834,0
                          c-0.276,0.418-0.555,0.835-0.832,1.252c-0.278,0-0.557,0-0.834,0c-0.14,0.278-0.278,0.557-0.418,0.835c-0.416,0-0.834,0-1.25,0
                          c-0.14,0.278-0.278,0.557-0.417,0.834c-0.973,0-1.946,0-2.919,0c-0.695-0.834-1.391-1.67-2.086-2.505c-0.138,0-0.276,0-0.416,0
                          c0-0.417,0-0.835,0-1.252c-0.139,0-0.278,0-0.417,0c0-0.277,0-0.556,0-0.834c-0.139,0-0.278,0-0.417,0c0-0.417,0-0.835,0-1.252
                          c-0.139,0-0.277,0-0.417,0c0-2.086,0-4.175,0-6.262c1.225-0.712,1.194-1.207,3.334-1.251c1.833-1.923,8.526-0.354,10.424,0.417
                          C89.768,28.89,89.691,28.938,89.591,29.922z"/>
                    <path id="52" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M49.148,34.515
                          c2.563-0.085,7.605,0.189,8.339,1.67c0,2.087,0,4.175,0,6.262c-2.58,1.55-1.64,2.952-6.254,2.922c0-0.139,0-0.278,0-0.417
                          c-0.694,0-1.389,0-2.084,0c-0.68-1.088-1.756-1.466-2.502-2.504c-0.139,0-0.278,0-0.416,0c0-1.392,0-2.783,0-4.174
                          c0.138,0,0.277,0,0.416,0c0-0.417,0-0.835,0-1.253c0.138,0,0.278,0,0.417,0C47.758,36.185,48.454,35.349,49.148,34.515z"/>
                    <path id="62" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M102.516,37.437c0,0.418,0,0.835,0,1.253
                          c0.14,0,0.279,0,0.418,0c0,0.139,0,0.278,0,0.417c0.556,0,1.11,0,1.668,0c0,0.139,0,0.278,0,0.417c0.138,0,0.276,0,0.416,0
                          c-0.138,0.835-0.277,1.67-0.416,2.504c-0.834,0.696-1.668,1.392-2.503,2.087c-0.138,0.278-0.277,0.557-0.416,0.835
                          c-0.417,0-0.833,0-1.25,0c-0.14,0.278-0.278,0.557-0.417,0.835c-0.974,0-1.945,0-2.919,0c-0.974-0.835-1.945-1.67-2.919-2.505
                          c0-0.278,0-0.557,0-0.835c-0.277-0.139-0.555-0.278-0.834-0.417c0-1.947,0-3.897,0-5.844c0.489-0.271,0.601-0.682,0.834-0.835
                          c0.278,0,0.557,0,0.834,0c0.14-0.278,0.277-0.556,0.418-0.834c1.667,0,3.335,0,5.003,0c1.128,1.235,2.281,0.706,3.335,2.505
                          c0.139,0,0.278,0,0.418,0c0,0.139,0,0.278,0,0.417C103.628,37.437,103.072,37.437,102.516,37.437z"/>
                    <path id="53" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M34.138,56.224c0-2.087,0-4.175,0-6.263
                          c2.697-1.641,2.108-4.559,6.671-4.592c1.013-1.433,1.243-0.527,2.501,0c0.417,0,0.834,0,1.251,0
                          c1.919,1.128,2.229,5.454,2.083,8.768c-1.016,0.595-1.715,1.685-2.918,2.088c-2.641,0.139-5.281,0.278-7.921,0.417
                          c-0.139-0.278-0.279-0.556-0.417-0.835C34.973,55.946,34.556,56.085,34.138,56.224z"/>
                    <path id="63" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M115.025,54.554
                          c0.138,0.557,0.277,1.114,0.416,1.67c-2.183,0.449-7.651,1.125-9.172-0.417c-0.733-0.579,0.154-0.098-0.417-0.835
                          c-0.556-0.417-1.112-0.835-1.668-1.252c-0.669-1.061-0.443-3.34-0.416-5.009c1.447-0.979,1.388-2.808,3.336-3.34
                          c0-0.139,0-0.277,0-0.417c0.44-0.271,1.979-0.14,2.502-0.417c0,0.139,0,0.278,0,0.417c0.477,0.18,1.157,0.205,1.668,0.417
                          c0,0.139,0,0.278,0,0.417c0.417,0,0.833,0,1.25,0c0,0.139,0,0.278,0,0.417c1.111,0.974,2.225,1.949,3.337,2.922
                          c0,0.278,0,0.557,0,0.835c0.276,0.139,0.555,0.278,0.832,0.417c0,1.53,0,3.062,0,4.592c-0.14,0-0.277,0-0.416,0
                          c0-0.139,0-0.277,0-0.417C115.859,54.554,115.441,54.554,115.025,54.554z"/>
                    <path id="54" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M39.976,74.175c-3.196,0-6.394,0-9.589,0
                          c-0.138-0.278-0.277-0.557-0.417-0.834c-0.417,0-0.834,0-1.251,0c0-0.14,0-0.279,0-0.418c-0.777-0.556-0.804-0.651-2.085-0.835
                          c0-1.392,0-2.783,0-4.175c0.417-0.278,0.834-0.557,1.251-0.834c0-0.278,0-0.557,0-0.835c0.277-0.139,0.555-0.278,0.833-0.417
                          c0-1.252,0-2.504,0-3.758c0.279-0.139,0.556-0.277,0.834-0.417c0.834-0.974,1.668-1.948,2.502-2.922
                          c1.38,0.248,3.093,0.42,5.003,0.417c0.615,0.94,1.902,1.208,2.502,2.087c0.278,0.834,0.555,1.67,0.833,2.505
                          c0.417,0.278,0.834,0.557,1.251,0.835c0,0.556,0,1.113,0,1.669c0.278,0.139,0.556,0.278,0.834,0.417c0,1.391,0,2.783,0,4.175
                          C41.31,71.487,40.328,72.718,39.976,74.175z"/>
                    <path id="64" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M117.944,59.146c0,0.278,0,0.557,0,0.835
                          c0.417,0,0.833,0,1.25,0c0.695,0.835,1.391,1.67,2.086,2.505c0.276,0.139,0.555,0.277,0.834,0.417c0,0.973,0,1.947,0,2.921
                          c0.416,0.277,0.832,0.557,1.25,0.835c0.14,1.53,0.278,3.062,0.416,4.591c-0.972-0.278-1.945-0.557-2.918-0.835
                          c0.229,0.847,0.317,1.176,0.834,1.67c0.278,0,0.555,0,0.834,0c0,0.139,0,0.278,0,0.417c-0.14,0-0.279,0-0.418,0
                          c-1.548,2.396-7.348,1.732-11.257,1.67c-0.279-0.417-0.556-0.834-0.834-1.252c-0.14,0-0.278,0-0.416,0
                          c-0.14-0.696-0.279-1.392-0.418-2.087c-0.277-0.139-0.556-0.278-0.834-0.417c0-1.391,0-2.783,0-4.175c0.14,0,0.278,0,0.418,0
                          c0.139-0.696,0.278-1.392,0.416-2.087c0.418-0.278,0.834-0.556,1.251-0.834c0-0.417,0-0.835,0-1.252
                          c0.417-0.277,0.834-0.557,1.251-0.834c0.277-0.417,0.556-0.835,0.833-1.252C113.867,59.048,115.621,59.111,117.944,59.146z"/>
                    <path id="55" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M27.885,76.262c2.223,0,4.447,0,6.67,0
                          c0.138,0.278,0.277,0.557,0.417,0.835c0.556,0,1.112,0,1.667,0c0,0.139,0,0.278,0,0.417c0.417,0,0.834,0,1.251,0
                          c0.556,0.696,1.112,1.392,1.668,2.087c0.417,0.277,0.833,0.557,1.25,0.834c0,0.417,0,0.835,0,1.252
                          c0.277,0.139,0.556,0.278,0.834,0.417c0,2.783,0,5.567,0,8.35c-0.139,0-0.278,0-0.416,0c0,0.417,0,0.835,0,1.252
                          c-0.557,0.418-1.112,0.835-1.668,1.252c0,0.278,0,0.557,0,0.835c-0.973,0.835-1.946,1.67-2.919,2.505c0,0.139,0,0.278,0,0.417
                          c-0.694,0-1.389,0-2.085,0c-1.061,0.993-3.559,0.116-5.002,0c-0.857-1.295-2.514-1.557-3.335-2.922c-0.139,0-0.278,0-0.418,0
                          c0-0.557,0-1.112,0-1.669c-0.138,0-0.277,0-0.417,0c0-0.278,0-0.557,0-0.834c-0.138,0-0.277,0-0.416,0c0-0.557,0-1.113,0-1.671
                          c-0.138,0-0.277,0-0.417,0c0-0.835,0-1.669,0-2.504c-0.138,0-0.277,0-0.416,0c0-0.278,0-0.557,0-0.835c-0.138,0-0.277,0-0.417,0
                          c0-2.087,0-4.175,0-6.263C25.285,79.199,27.015,77.787,27.885,76.262z"/>
                    <path id="65" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M126.283,79.184
                          c0.139,0.417,0.278,0.834,0.417,1.251c0.14,0,0.277,0,0.416,0c0,0.417,0,0.835,0,1.252c0.279,0.139,0.556,0.278,0.834,0.417
                          c0,1.948,0,3.897,0,5.844c-0.473,0.354-0.061-0.052-0.418,0.417c-0.416,0-0.833,0-1.249,0c0,0.556,0,1.113,0,1.67
                          c-0.484,0.243-0.658,0.732-0.835,0.835c-0.417,0-0.833,0-1.251,0c0,0.139,0,0.278,0,0.417c0.852,0.56,0.784,0.684,0.834,2.087
                          c-0.834,0.696-1.668,1.392-2.503,2.086c0,0.139,0,0.278,0,0.417c-0.416,0-0.832,0-1.25,0c-0.14,0.278-0.278,0.557-0.416,0.835
                          c-1.112,0-2.225,0-3.336,0c-2.507,2.258-6.742-4.001-7.923-5.009c-0.14-2.505-0.277-5.01-0.416-7.515c0.139,0,0.276,0,0.416,0
                          c0-1.113,0-2.227,0-3.34c0.834-0.695,1.668-1.392,2.501-2.087c0.139-0.278,0.278-0.556,0.417-0.835
                          c0.835-0.139,1.668-0.277,2.503-0.417c0-0.139,0-0.278,0-0.417c0.276,0,0.555,0,0.833,0c0-0.139,0-0.277,0-0.417
                          c2.225,0,4.447,0,6.671,0c0,0.139,0,0.278,0,0.417c0.416,0,0.834,0,1.251,0c0,0.139,0,0.278,0,0.417
                          C125.125,78.566,124.131,78.848,126.283,79.184z"/>
                    <path id="85" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M28.301,155.164c0-0.278,0-0.557,0-0.835
                          c-0.99,0.084-1.031,0.175-1.668,0.419c-0.139-0.419-0.278-0.835-0.417-1.254c-0.139,0-0.277,0-0.417,0c0-0.276,0-0.557,0-0.835
                          c-0.277-0.14-0.555-0.278-0.833-0.416c-0.139-0.976-0.278-1.948-0.417-2.922c-0.277-0.14-0.555-0.278-0.833-0.418
                          c0-2.922,0-5.845,0-8.767c0.139,0,0.278,0,0.417,0c0-0.278,0-0.557,0-0.835c0.278-0.14,0.555-0.278,0.834-0.418
                          c0-0.416,0-0.835,0-1.251c0.138,0,0.277,0,0.416,0c0,0.139,0,0.277,0,0.416c0.781,0.393,1.757-0.233,2.085-0.416
                          c0-0.14,0-0.279,0-0.418c0.417,0,0.834,0,1.25,0c0-0.14,0-0.278,0-0.418c0.139,0,0.278,0,0.417,0c0,0.14,0,0.278,0,0.418
                          c0.834,0,1.668,0,2.502,0c0,0.139,0,0.278,0,0.418c0.833,0.139,1.667,0.277,2.501,0.416c0.277,0.419,0.555,0.835,0.834,1.253
                          c0.139,0,0.278,0,0.417,0c0,0.278,0,0.557,0,0.835c0.277,0.139,0.555,0.278,0.833,0.417c0,0.418,0,0.835,0,1.253
                          c0.277,0.139,0.556,0.277,0.833,0.417c0,1.251,0,2.505,0,3.758c0.278,0.139,0.556,0.276,0.834,0.417c0,0.278,0,0.557,0,0.835
                          c0.138,0,0.277,0,0.416,0c-0.278,1.808-0.556,3.618-0.833,5.426c-0.802,0.432-1.702,1.322-2.502,1.67
                          C33.272,155.07,30.615,155.151,28.301,155.164z"/>
                    <path id="75" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M115.025,139.301
                          c0.933-0.25,1.043-0.349,1.668-0.834c0-0.14,0-0.28,0-0.418c0.276,0,0.556,0,0.834,0c0.138-0.278,0.277-0.557,0.416-0.835
                          c1.389,0,2.779,0,4.169,0c0,0.138,0,0.278,0,0.416c0.974,0.141,1.946,0.278,2.919,0.417c0,0.14,0,0.278,0,0.419
                          c2.193,1.806,1.309,9.075,1.252,12.94c-0.14,0-0.279,0-0.418,0c0,0.278,0,0.557,0,0.835c-0.139,0-0.277,0-0.417,0
                          c-0.833,0.975-1.669,1.948-2.502,2.923c-2.084,0-4.17,0-6.253,0c-0.418-0.557-0.834-1.113-1.252-1.67c-0.278,0-0.557,0-0.833,0
                          c-0.278-0.418-0.557-0.836-0.834-1.253c-0.278-0.139-0.557-0.276-0.834-0.417c0-1.67,0-3.34,0-5.008
                          c1.698-1.55,0.475-3.646,1.251-5.845c0.14,0,0.279,0,0.417,0C114.747,140.414,114.886,139.857,115.025,139.301z"/>
                    <path id="74" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M119.194,157.669
                          c-0.138,0.695-0.277,1.391-0.417,2.087c0.417,0.139,0.834,0.278,1.253,0.417c0,0.14,0,0.278,0,0.417
                          c1.069,0.745,0.796-0.451,1.25,1.253c0.618,0.665,0.455,2.46,0.416,3.758c-1.04,0.949-0.288,1.167-0.834,2.087
                          c-0.14,0-0.278,0-0.418,0c-0.277,0.418-0.555,0.835-0.834,1.253c-0.277,0-0.555,0-0.833,0c-0.278,0.417-0.556,0.835-0.833,1.252
                          c-0.279,0-0.557,0-0.834,0c-0.139,0.278-0.278,0.557-0.417,0.835c-1.158,0.591-4.102,0.024-6.253,0
                          c-1.465-2.37-3.568-1.719-3.754-5.845c1.436-1.063,0.138-0.728,0.835-2.087c0.277-0.14,0.556-0.278,0.834-0.418
                          c0-0.277,0-0.557,0-0.834c0.278-0.139,0.555-0.277,0.834-0.416c0-0.836,0-1.671,0-2.505c0.276-0.14,0.555-0.278,0.833-0.418
                          c0-0.278,0-0.557,0-0.834c0.277-0.14,0.556-0.278,0.834-0.418c0.277-0.417,0.556-0.835,0.835-1.252c1.667,0,3.334,0,5.002,0
                          C117.226,156.677,118.207,157.417,119.194,157.669z"/>
                    <path id="84" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M32.887,156.417c2.085,0,4.17,0,6.255,0
                          c0.416,0.557,0.833,1.113,1.25,1.67c0.139,0,0.278,0,0.417,0c0,0.556,0,1.112,0,1.669c0.277,0.139,0.557,0.278,0.834,0.417
                          c0,0.696,0,1.392,0,2.089c0.417,0.277,0.834,0.556,1.251,0.834c0.677,1.076,0.802,2.863,0.833,4.592
                          c-2.684,1.592-1.979,2.938-6.67,2.923c0,0.139,0,0.278,0,0.417c-0.694,0-1.389,0-2.084,0c-0.039,0.012,0.077,0.261-0.834,0.418
                          c-0.891-1.274-0.592-0.178-1.668-0.835c-0.278-0.417-0.556-0.835-0.833-1.253c-2.05-2.004-3.304-2.971-3.336-7.096
                          c1.271-0.878,0.224-0.442,0.834-1.671c0.139,0,0.278,0,0.417,0c0-0.277,0-0.556,0-0.834c0.277-0.14,0.556-0.278,0.833-0.418
                          C31.22,158.365,32.054,157.391,32.887,156.417z"/>
                    <path id="73" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M105.018,183.553c-0.556,0-1.111,0-1.666,0
                          c-1.328-2.217-3.307-2.124-3.336-5.846c-1.123-1.162-0.011-3.61,0.417-4.592c1.088-0.576,0.706-0.739,2.501-0.835
                          c0-0.139,0-0.278,0-0.417c0.666-0.413,6.04,0.296,6.255,0.417c0.555,0.696,1.11,1.392,1.667,2.088c0.491,0.32,1.846,0.483,2.085,0
                          c0,0.834,0,1.669,0,2.505c-1.484,1.109-0.534,1.789-1.25,3.339c-0.974,1.113-1.947,2.228-2.919,3.341c-0.974,0-1.945,0-2.92,0
                          c0,0.141,0,0.278,0,0.417c-0.277,0.14-0.556,0.28-0.833,0.418C105.018,184.108,105.018,183.831,105.018,183.553z"/>
                    <path id="83" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M37.891,176.456c0.277,0,0.555,0,0.833,0
                          c0.957-2.189,2.642-3.371,5.837-3.341c0-0.139,0-0.278,0-0.417c0.833,0,1.667,0,2.5,0c0,0.139,0,0.278,0,0.417
                          c0.417,0,0.834,0,1.251,0c0.139,0.278,0.278,0.557,0.416,0.835c2.079,1.916,1.865,2.693,1.668,6.68
                          c-1.019,0.651-0.254,0.476-0.833,1.253c-1.112,0.974-2.224,1.948-3.336,2.922c-1.667-0.139-3.335-0.276-5.003-0.417
                          c-0.695-0.835-1.39-1.67-2.084-2.505c-0.139,0-0.278,0-0.417,0c0-0.418,0-0.836,0-1.253c-0.139,0-0.278,0-0.417,0
                          c0-0.277,0-0.556,0-0.835c-0.139,0-0.277,0-0.416,0C37.891,178.682,37.891,177.568,37.891,176.456z"/>
                    <path id="72" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M100.015,186.893c-0.416,0-0.834,0-1.252,0
                          c0.279,0.835,0.556,1.669,0.834,2.505c-0.139,0-0.278,0-0.416,0c-0.694,0.874-1.515,1.04-2.503,1.67
                          c-0.139,0.277-0.278,0.556-0.416,0.835c-1.808,0-3.613,0-5.421,0c-0.412-0.69-1.95-1.808-2.085-2.088c0-1.53,0-3.062,0-4.592
                          c0.475-0.477,0.165-0.001,0.418-0.835c0.694-0.557,1.39-1.113,2.085-1.67c0-0.14,0-0.278,0-0.418c0.277,0,0.556,0,0.834,0
                          c0.138-0.276,0.276-0.557,0.416-0.835c1.806,0,3.612,0,5.419,0c0.696,0.835,1.391,1.67,2.085,2.505
                          C100.015,184.944,100.015,185.918,100.015,186.893z"/>
                    <path id="82" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M51.649,182.718
                          c3.39-0.079,5.699,0.322,7.922,1.252c0.271,0.49,0.68,0.601,0.833,0.835c0,0.278,0,0.557,0,0.835
                          c0.277,0.139,0.555,0.278,0.833,0.417c0,1.67,0,3.34,0,5.01c-1.096,0.629-1.408,1.331-2.918,1.67c0,0.278,0,0.557,0,0.835
                          c-1.667-0.278-3.336-0.557-5.002-0.835c-0.834-0.974-1.669-1.948-2.503-2.924c-0.277-0.138-0.555-0.278-0.833-0.416
                          c0-1.532,0-3.062,0-4.592C50.893,184.304,51.356,183.885,51.649,182.718z"/>
                    <path id="71" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M87.088,195.659
                          c-1.389,0.139-2.778,0.277-4.168,0.417c0,0.14,0,0.278,0,0.417c0.548,0.338,0.49,0.296,0.834,0.835c-0.277,0-0.557,0-0.834,0
                          c-0.139,0.278-0.277,0.557-0.417,0.835c-1.25,0-2.501,0-3.753,0c-0.47-0.717-0.264-0.565-1.25-0.835
                          c-0.098-1.076-0.053-1.432-0.417-2.087c-0.139,0-0.278,0-0.417,0c-0.428-1.06,0.525-5.741,0.834-6.262
                          c0.416-0.278,0.833-0.557,1.25-0.835c0.727-0.752,1.832-0.833,3.335-0.835c0.417,0.557,0.835,1.115,1.252,1.67
                          c0.277,0,0.556,0,0.834,0c0.416,0.557,0.834,1.113,1.25,1.67c0.278,0,0.555,0,0.833,0c0.279,0.418,0.558,0.835,0.834,1.253
                          c0.142,0,0.278,0,0.418,0c0,0.696,0,1.392,0,2.088c-0.14,0-0.276,0-0.418,0C87.088,194.546,87.088,195.102,87.088,195.659z"/>
                    <path id="81" stroke="#000000" fill="transparent" class="mini" stroke-width="0.5" stroke-miterlimit="10" d="M69.578,188.145c0.834,0,1.669,0,2.502,0
                          c0.417,0.557,0.834,1.113,1.251,1.67c0.14,0,0.278,0,0.417,0c0,2.503,0,5.009,0,7.514c-0.417,0.14-0.834,0.278-1.251,0.418
                          c-0.138,0.277-0.278,0.557-0.417,0.835c-1.39,0-2.78,0-4.169,0c0-0.14,0-0.278,0-0.418c-0.695-0.139-1.389-0.278-2.085-0.417
                          c-0.277-0.418-0.555-0.835-0.833-1.253c-1.724-1.56-1.722-0.067-1.668-3.757c1.529-1.392,3.057-2.783,4.586-4.175
                          c0.555,0,1.111,0,1.667,0C69.578,188.423,69.578,188.283,69.578,188.145z"/>
                    </g>
                    </g>
                    </svg>
                </div>
                <div class="span8" id="uploaderX">

                </div>
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
<div id="modal-gallery" class="modal modal-gallery hide fade" data-filter=":odd">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">&times;</a>
        <h3 class="modal-title"></h3>
    </div>
    <div class="modal-body"><div class="modal-image"></div></div>
    <div class="modal-footer">
        <a class="btn modal-download" target="_blank">
            <i class="icon-download"></i>
            <span>Descargar</span>
        </a>
        <a class="btn btn-success modal-play modal-slideshow" data-slideshow="5000">
            <i class="icon-play icon-white"></i>
            <span>Slideshow</span>
        </a>
        <a class="btn btn-info modal-prev">
            <i class="icon-arrow-left icon-white"></i>
            <span>Anterior</span>
        </a>
        <a class="btn btn-primary modal-next">
            <span>Siguiente</span>
            <i class="icon-arrow-right icon-white"></i>
        </a>
    </div>
</div>
<div id="modal-gallery" class="modal modal-gallery hide fade" data-filter=":odd">
    <div class="modal-header">
        <a class="close" data-dismiss="modal">&times;</a>
        <h3 class="modal-title"></h3>
    </div>
    <div class="modal-body"><div class="modal-image"></div></div>
    <div class="modal-footer">
        <a class="btn modal-download" target="_blank">
            <i class="icon-download"></i>
            <span>Descargar</span>
        </a>
        <a class="btn btn-success modal-play modal-slideshow" data-slideshow="5000">
            <i class="icon-play icon-white"></i>
            <span>Slideshow</span>
        </a>
        <a class="btn btn-info modal-prev">
            <i class="icon-arrow-left icon-white"></i>
            <span>Anterior</span>
        </a>
        <a class="btn btn-primary modal-next">
            <span>Siguiente</span>
            <i class="icon-arrow-right icon-white"></i>
        </a>
    </div>
</div></div>


