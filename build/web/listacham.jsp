
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
        <link rel="stylesheet" href="tabela.css"/>
        <title>Listagem de Chamados</title>
    </head>
    <body>
        <%

            try {
                Connection conecta;
                PreparedStatement stat;
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url="jdbc:mysql://mysqldb-ghvs.mysql.database.azure.com:3306/bancoaulapi?useSSL=true";
                conecta = DriverManager.getConnection(url, "guilhermehvsroot", "$eN@C3229");
                //Listar chamados
                stat = conecta.prepareStatement("SELECT * FROM chamado Order by codigo");
                ResultSet resultado = stat.executeQuery();
        %>
        <table>
            <thead>
                <tr>
                    <th>Id</th>
                    <th>Nome</th>
                    <th>Setor</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>Mensagem</th>
                    <th>Tipo</th>
                    <th>Excluir</th>
                    <th>Editar</th>
                </tr>
            </thead>
            <%
                while (resultado.next()) {
            %>
            <tbody>
            <td ><%=resultado.getString("codigo")%></td>
            <td ><%=resultado.getString("nome")%></td>
            <td ><%=resultado.getString("setor")%></td>
            <td ><%=resultado.getString("email")%></td>
            <td ><%=resultado.getString("telefone")%></td>
            <td ><%=resultado.getString("mensagem")%></td>
            <td ><%=resultado.getString("tipo")%></td>
            <td class="icones"><a title="Excluir" href="excluir_chamado.jsp?codigo=<%=resultado.getString("codigo")%>"><img src="delete.png" alt="excluir" width="30px"></a></td>
            <td class="icones"><a title="Editar" href="carrega_cham.jsp?codigo=<%=resultado.getString("codigo")%>"><img src="pencil.png" alt="editar" width="30px"></a></td>
        </tbody>
        <%
            }
        %>
    </table> 
    <%
        } catch (Exception erro) {
            out.print("Mensagem de erro: " + erro.getMessage());
        }


    %>
</body>
</html>
