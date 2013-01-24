<%-- 
    Document   : listar
    Created on : 22/01/2013, 06:55:57 AM
    Author     : jubarcos
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(function(){
        $(".estado").click(function(ev){
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
    <h2>Listado de  Docentes</h2>
    <c:choose>
        <c:when test="${docentes.getRowCount()!= 0}">

            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <th>Identificaci&oacute;n</th>    
                <th>Docente</th>
                <th>Acci&oacute;n</th>
                </thead>
                <tbody>
                    <c:forEach items="${docentes.rowsByIndex}" var="row" varStatus="iter">
                        <tr>
                            <td>   
                                <c:out value="${row[0]}"/>
                            </td>
                            <td>   
                                <a href="#listaMedicos&${row[0]}" title="Ver medicos asociados">${row[1]}</a>
                            </td>
                            <td class="action icon16">
                                <a href="#verDocente&${row[0]}" title="Ver docente"><i class="icon-eye-open"></i></a>
                                <a href="#editarDocente&${row[0]}" title="Editar docente"><i class="icon-pencil"></i></a>
                                <c:choose>
                                    <c:when test="${row[4]=='activo'}">
                                        <a class="estado" href="#cambiarEstado&${row[0]}" title="Activo"><i class="icon-ok"></i></a>        
                                    </c:when>
                                    <c:otherwise>
                                        <a class="estado" href="#cambiarEstado&${row[0]}" title="Inactivo"><i class="icon-off"></i></a>        
                                    </c:otherwise>
                                </c:choose>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            No existen docentes registrados en el sistema.
        </c:otherwise>
    </c:choose>
</div>



