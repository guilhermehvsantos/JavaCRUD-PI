
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="tabela.css"/>
        <title>Pesquisar Chamados</title>
    </head>
    <body>
        <%
            //Recebe o nome do formulario de consulta
            String nome;
            nome = request.getParameter("nome");

            //Conecta com o banco de dados
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta;
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoaulapi","root","$en@c!32");

                //Excluindo do banco de dados
                PreparedStatement stat;
                stat = conecta.prepareStatement("SELECT * FROM chamado WHERE nome LIKE ? ORDER BY nome");
                stat.setString(1, "%" + nome + "%");
                ResultSet resultado = stat.executeQuery();
                //Verifica se foi excluido ou nao
                if(!resultado.next()) {
                    out.print("<p style='color:red; font-size:30px; font-weight: bold; margin: 20px;'>Não existe chamado com esse nome</p>");
                } else {
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
        }
        } catch (Exception erro) {
            out.print("Mensagem de erro: " + erro.getMessage());
        }

    %>
</body>
</html>
