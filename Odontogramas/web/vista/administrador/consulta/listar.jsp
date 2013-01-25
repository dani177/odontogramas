<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                            <td><a href="#verConsulta&${row[0]}">Ver</a></td>
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

