<script type="text/javascript">
    $(function(){
        $('.fechas').datepicker();
        $("#intervalo").validate({
            submitHandler: function() {
                $.getScript("http://code.highcharts.com/highcharts.js")
                .done(function(script, textStatus) {
                    $.getScript("http://code.highcharts.com/modules/exporting.js")
                    .done(function(script, textStatus) {
                        $.ajax({
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/formController?action=mostrarInforme",
                            data: $("#intervalo").serialize(),
                            success: function(data) {
                                var da = data.split("-");
                                $('#info').highcharts({
                                    chart: {
                                        type: 'column',
                                        width:              300,
                                        height:             400
                                    },
                                    title: {
                                        text: 'Número de consultas'
                                    },
                                    xAxis: {
                                        categories: [ 
                                            'Consultas'
                                        ]
                                    },
                                    yAxis: {
                                        min: 0,
                                        title: {
                                            text: 'Cantidad'
                                        }
                                    },
                                    tooltip: {
                                        shared: true,
                                        useHTML: true
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0
                                        }
                                    },
                                    series: [{
                                            data: [parseInt(da[0])]
                                        }]
                                });
                   
                                $('#info2').highcharts({
                                    chart: {
                                        type: 'column',
                                        width:              300,
                                        height:             400
                                    },
                                    title: {
                                        text: 'Número de tratamientos realizados'
                                    },
                                    xAxis: {
                                        categories: [ 
                                            'Tratamientos'
                                        ]
                                    },
                                    yAxis: {
                                        min: 0,
                                        title: {
                                            text: 'Cantidad'
                                        }
                                    },
                                    tooltip: {
                                        shared: true,
                                        useHTML: true
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0
                                        }
                                    },
                                    series: [{
                                            data: [parseInt(da[1])]
                                        }]
                                });
                   
                                $('#info3').highcharts({
                                    chart: {
                                        type: 'column',
                                        width:              300,
                                        height:             400
                                    },
                                    title: {
                                        text: 'Total dinero recaudado'
                                    },
                                    xAxis: {
                                        categories: [ 
                                            'Dinero'
                                        ]
                                    },
                                    yAxis: {
                                        min: 0,
                                        title: {
                                            text: 'Cantidad'
                                        }
                                    },
                                    tooltip: { 
                                        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                                        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                                            '<td style="padding:0"><b>$ {point.y:.1f} </b></td></tr>',
                                        footerFormat: '</table>',
                                
                                        shared: true,
                                        useHTML: true
                                    },
                                    plotOptions: {
                                        column: {
                                            pointPadding: 0.2,
                                            borderWidth: 0
                                        }
                                    },
                                    series: [{
                                            data: [parseInt(da[2])]
                                        }]
                                });
                               
    
                            } //fin success
                        }); //fin $.ajax  
                    })
                    
                      
                })     
                 
                
                
                
            }
        });
    })
</script>

<div class="span12">
    <form class="form-horizontal" id="intervalo" method="post">
        <fieldset>
            <legend>Ingrese intervalo de fechas para mostrar el informe</legend>
            <div class="control-group">
                <label for="fecha1" class="control-label">Fecha inicial</label>
                <div class="controls">
                    <input type="text" id="fecha1" name="fecha1" class="input-medium fechas" data-datepicker="datepicker" value="" />
                </div>
            </div>
            <div class="control-group">
                <label for="fecha2" class="control-label">Fecha final</label>
                <div class="controls">
                    <input type="text" id="fecha2" name="fecha2" class="input-medium fechas" data-datepicker="datepicker" value="" />
                </div>
            </div>
            <div class="form-actions">
                <button class="btn btn-primary" type="submit">Mostrar informe</button>

            </div>
        </fieldset>
    </form>
    <div class="row">
        <div id="info3" class="span4" ></div>
        <div id="info" class="span4" ></div>
        <div id="info2" class="span4" ></div>

    </div>




</div> <!--/span-->