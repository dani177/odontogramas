<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
<!-- Shim to make HTML5 elements usable in older Internet Explorer versions -->
<!--[if lt IE 9]><script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

<script src='<%=request.getContextPath()%>/js/jquery.reel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.disabletextselect-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.mousewheel-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/jquery.cookie-min.js' type='text/javascript'></script>
<script src='<%=request.getContextPath()%>/js/sampler.js' type='text/javascript'></script>
<script src="<%=request.getContextPath()%>/assets/js/jquery.ba-hashchange.js"></script>
<style type="text/css">
    .diente{
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
                data: ""+$("#fileupload").serialize(),
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
        <li ><a href="#otro" data-toggle="tab"> Examen Fisico estomatologico</a></li>
        <li ><a href="#odontoIn" data-toggle="tab"> Dentici&oacute;n permanente</a></li>
        <li ><a href="#odontoFi" data-toggle="tab"> Dentici&oacute;n temporal</a></li>
        <li ><a href="#diag" data-toggle="tab"> Diagnostico y tratamiento </a></li>
        <li ><a href="#histo" data-toggle="tab"> Historia clinica</a></li>
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



        <!-----------------PESTANA 2---------------------------->
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
                <form id="fileupload" action="<%=request.getContextPath()%>/Odontogramas" method="POST" enctype="multipart/form-data">
                    <legend>Examen radiogr&aacute;fico</legend>

                    <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
                    <div class="fileupload-buttonbar">
                        <div class="span7">
                            <!-- The fileinput-button span is used to style the file input field as button -->
                            <span class="btn btn-success fileinput-button">
                                <i class="icon-plus icon-white"></i>
                                <span>Añadir Archivos...</span>
                                <input type="file" name="files[]" multiple>
                            </span>
                            <button type="submit" class="btn btn-primary start">
                                <i class="icon-upload icon-white"></i>
                                <span>Iniciar Subida</span>
                            </button>
                            <button type="reset" class="btn btn-warning cancel">
                                <i class="icon-ban-circle icon-white"></i>
                                <span>Cancelar subida</span>
                            </button>
                            <button type="button" class="btn btn-danger delete">
                                <i class="icon-trash icon-white"></i>
                                <span>Borrar</span>
                            </button>
                            <input type="checkbox" class="toggle">
                        </div>
                        <!-- The global progress information -->
                        <div class="span5 fileupload-progress fade">
                            <!-- The global progress bar -->
                            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                <div class="bar" style="width:0%;"></div>
                            </div>
                            <!-- The extended global progress information -->
                            <div class="progress-extended">&nbsp;</div>
                        </div>
                    </div>
                    <!-- The loading indicator is shown during file processing -->
                    <div class="fileupload-loading"></div>
                    <br>
                    <!-- The table listing the files available for upload/download -->
                    <table role="presentation" class="table table-striped">
                        <tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery">
                        </tbody>
                    </table>

                

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
                </form>
                <form>
                    <fieldset>
                        <legend>Preparaci&oacute;n biom&eacute;dica</legend>
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>Canal</th>
                                    <th>Referencia</th>
                                    <th>L.A</th>
                                    <th>L.R.I</th>
                                    <th>L.R.T</th>
                                    <th>Inst Inicial</th>
                                    <th>Lima retroceso</th>
                                    <th>Prepaci&oacute;n apical</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" value="" name="canal" class="input-small"/></td>
                                    <td><input type="text" value="" name="referencia" class="input-small"/></td>
                                    <td><select name="la" class="input-small">
                                            <option value="10">10</option>    
                                            <option value="15">15</option>    
                                            <option value="20">20</option>    
                                            <option value="25">25</option>    
                                            <option value="30">30</option>    
                                        </select>
                                    </td>
                                    <td><select name="lri" class="input-small">
                                            <option value="10">10</option>    
                                            <option value="15">15</option>    
                                            <option value="20">20</option>    
                                            <option value="25">25</option>    
                                            <option value="30">30</option>    
                                        </select></td>
                                    <td><select name="lrt" class="input-small">
                                            <option value="10">10</option>    
                                            <option value="15">15</option>    
                                            <option value="20">20</option>    
                                            <option value="25">25</option>    
                                            <option value="30">30</option>    
                                        </select></td>
                                    <td><select name="inst" class="input-small">
                                            <option value="15">15</option>    
                                            <option value="20">20</option>    
                                            <option value="25">25</option>    
                                            <option value="30">30</option>    
                                            <option value="35">35</option>    
                                            <option value="40">40</option>    
                                            <option value="45">45</option>    
                                            <option value="50">50</option>    
                                            <option value="60">60</option>    
                                            <option value="70">70</option>    
                                            <option value="80">80</option>    
                                        </select></td>
                                    <td><input type="text" value="" name="lima" class="input-small"/></td>
                                    <td><input type="text" value="" name="preparacion" class="input-small"/></td>
                                </tr>
                            </tbody>
                        </table>
                        <legend>Control de tratamiento</legend>
                        <div class="control-group">
                            <label class="control-label" for="fechaTrat">Fecha</label>
                            <div class="controls">
                                <input type="text" name="fechaTrat" id="fechaTrat" class="input-medium fecha" data-datepicker="datepicker">
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="tratamientoR">Tratamiento realizado</label>
                            <div class="controls">
                                <input type="text" name="tags10" autocomplete="off" id="tratamientoR" placeholder="Tratamiento realizado" class="tagManager10"/>
                            </div>
                        </div>
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

<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">

        <td class="preview"><span class="fade"></span></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
        <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
        <td>
            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
        </td>
        <td class="start">{% if (!o.options.autoUpload) { %}
            <button class="btn btn-primary">
                <i class="icon-upload icon-white"></i>
                <span>{%=locale.fileupload.start%}</span>
            </button>
            {% } %}</td>
        {% } else { %}
        <td colspan="2"></td>
        {% } %}
        <td class="cancel">{% if (!i) { %}
            <button class="btn btn-warning">
                <i class="icon-ban-circle icon-white"></i>
                <span>{%=locale.fileupload.cancel%}</span>
            </button>
            {% } %}</td>
    </tr>
    {% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
        <td></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td class="error" colspan="2"><span class="label label-important">{%=locale.fileupload.error%}</span> {%=locale.fileupload.errors[file.error] || file.error%}</td>
        {% } else { %}
        <td class="preview">{% if (file.thumbnail_url) { %}
            <a href="{%=file.url%}" title="{%=file.name%}" rel="gallery" download="{%=file.name%}"><img src="{%=file.thumbnail_url%}"></a>
            {% } %}</td>
        <td class="name">
            <a href="{%=file.url%}" title="{%=file.name%}" rel="{%=file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
        </td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td colspan="2"></td>
        {% } %}
        <td class="delete">
            <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                <i class="icon-trash icon-white"></i>
                <span>{%=locale.fileupload.destroy%}</span>
            </button>
            <input type="checkbox" name="delete" value="1">
        </td>
    </tr>
    {% } %}
</script>

<script src="<%=request.getContextPath()%>/assets/js/jquery.ba-hashchange.js"></script>

<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="<%=request.getContextPath()%>/js/vendor/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<script src="http://blueimp.github.com/JavaScript-Templates/tmpl.min.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="http://blueimp.github.com/JavaScript-Canvas-to-Blob/canvas-to-blob.min.js"></script>
<!-- Bootstrap JS and Bootstrap Image Gallery are not required, but included for the demo -->

<script src="http://blueimp.github.com/JavaScript-Load-Image/load-image.min.js"></script>
<script src="<%=request.getContextPath()%>/js/bootstrap-image-gallery.min.js"></script>



<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="<%=request.getContextPath()%>/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="<%=request.getContextPath()%>/js/jquery.fileupload.js"></script>
<!-- The File Upload file processing plugin -->
<script src="<%=request.getContextPath()%>/js/jquery.fileupload-fp.js"></script>
<!-- The File Upload user interface plugin -->
<script src="<%=request.getContextPath()%>/js/jquery.fileupload-ui.js"></script>
<!-- The localization script -->
<script src="<%=request.getContextPath()%>/js/locale.js"></script>
<!-- The main application script -->
<script src="<%=request.getContextPath()%>/js/main.js"></script>
<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE8+ -->
<!--[if gte IE 8]><script src="js/cors/jquery.xdr-transport.js"></script><![endif]-->

