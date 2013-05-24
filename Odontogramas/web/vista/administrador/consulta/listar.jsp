<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $(".estado2").click(function(ev){
            ev.preventDefault();
            ev.stopPropagation();
            var url = $(this).attr("href");
            if(confirm('Desea cambiar el estado?')){
                location.href = url;
            }
        });
    })
</script>

<div class="span9">
    <br/>
    <h2>Listado de Consultas</h2>
    <c:choose>
        <c:when test="${listaDeConsulta.getRowCount()!= 0}">

            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <th>Fecha</th>    
                <th>Acci&oacute;n</th>
                </thead>
                <tbody>
                    <c:forEach items="${listaDeConsulta.rowsByIndex}" var="row" varStatus="iter">
                        <tr>
                            <td>   
                                <fmt:formatDate pattern="yyyy-MM-dd" value="${row[8]}"></fmt:formatDate>
                            </td>
                            <td class="action icon16">
                                <a class="icon-eye-open" href="#verConsulta&${row[0]}" title="Ver"></a> 
                                <a class="icon-edit" href="#editarConsulta&${row[0]}" title="Editar"></a>
                                <c:choose>
                                    <c:when test="${row[14]=='activo'}">
                                        <a class="estado2" href="#cambiarCEstado&${row[0]}" title="Activo"><i class="icon-ok"></i></a>        
                                    </c:when>
                                    <c:otherwise>
                                        <a class="estado2" href="#cambiarCEstado&${row[0]}" title="Inactivo"><i class="icon-off"></i></a>        
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            No existen Consultas para este paciente registradas en el sistema.
        </c:otherwise>
    </c:choose>
</div>

