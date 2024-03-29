<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="span9">
    <br/>
    <h2>Listado de Consultas</h2>
    <c:choose>
        <c:when test="${listaDeConsulta.getRowCount()!= 0}">
            <c:set var="aux" value="0"></c:set>
            <table class="table table-striped table-bordered table-condensed">
                <thead>
                <th>Fecha</th>    
                <th>Acci&oacute;n</th>
                </thead>
                <tbody>
                    <c:forEach items="${listaDeConsulta.rowsByIndex}" var="row" varStatus="iter">
                        <c:choose>
                            <c:when test="${row[14]=='activo'}">
                                <c:set var="aux" value="1"></c:set>
                                <tr>
                                    <td>   
                                        <fmt:formatDate pattern="yyyy-MM-dd" value="${row[8]}"></fmt:formatDate>
                                    </td>
                                    <td class="action icon16">
                                        <a class="icon-eye-open" href="#verConsulta&${row[0]}" title="Ver"></a> 
                                        <a class="icon-edit" href="#editarConsulta&${row[0]}" title="Editar"></a>
                                    </td>
                                </tr>
                            </c:when>
                        </c:choose>

                    </c:forEach>
                    <c:choose>
                        <c:when test="${aux=='0'}">
                            <tr>
                                <td>   
                                    No existen Consultas para este paciente registradas en el sistema.                     
                                </td>
                                <td></td>
                            </tr>
                        </c:when>
                    </c:choose>            
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            No existen Consultas para este paciente registradas en el sistema.
        </c:otherwise>
    </c:choose>
</div>

