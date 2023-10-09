
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
        <link rel="stylesheet" href="styles.css"/>
        <title>Excluir Chamados</title>
    </head>
    <body>
        <%
            //Recebe o codigo do formulario
            int codigo;
            codigo = Integer.parseInt(request.getParameter("codigo"));
            
            //Conecta com o banco de dados
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta;
                String url="jdbc:mysql://mysqldb-ghvs.mysql.database.azure.com:3306/bancoaulapi?useSSL=true";
                conecta = DriverManager.getConnection(url, "guilhermehvsroot", "$eN@C3229");

                //Excluindo do banco de dados
                PreparedStatement stat;
                stat = conecta.prepareStatement("DELETE FROM chamado WHERE codigo=?");
                stat.setInt(1,codigo);
                int resultado = stat.executeUpdate();
                //Verifica se foi excluido ou nao
                if(resultado == 0) {
                    out.print("<p style='color:red; font-size:30px; font-weight: bold; margin: 20px;'>Não existe chamado com esse código</p>");
                } else {
                    out.print("<p style='color:#1a73e8; font-size:20px margin: 20px;'>O chamado de código " + codigo + " foi excluido com sucesso</p>");
                }
            } catch (Exception erro) {
                String menErro = erro.getMessage();
                out.print("<p style='color:red; font-size:20px margin: 20px;'>Entre em contato com o suporte e informe o erro: " + erro.getMessage() +"</p>");
                
            }
            
        %>
    </body>
</html>
