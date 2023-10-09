<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset="ISO-8859-1">
        <title>Alterar Chamado</title>
    </head>
    <body>
        <%
             //Recebendo dados ALTERADOS carrege_cham.jsp do formulário
            String nome, setor, email, telefone, tipo, mensagem;
            int codigo = Integer.parseInt(request.getParameter("codigo"));
            nome = request.getParameter("nome");
            setor = request.getParameter("setor");
            email = request.getParameter("email");
            telefone = request.getParameter("telefone");
            tipo = request.getParameter("tipo");
            mensagem = request.getParameter("mensagem");
            
            //Conecta com o banco de dados

            Connection conecta;
            PreparedStatement stat;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/bancoaulapi","root","1234");
            
            stat = conecta.prepareStatement("UPDATE chamado SET nome=?, setor=?, email=?, telefone=?, mensagem=?, tipo=? WHERE codigo=?");
            stat.setString(1,nome);
            stat.setString(2,setor);
            stat.setString(3,email);
            stat.setString(4,telefone);
            stat.setString(5,mensagem);
            stat.setString(6,tipo);
            stat.setInt(7,codigo);
            stat.executeUpdate();
            //Execute Update
            out.print("<p style='color:green; font-size:30px; font-weight: bold;'>O chamado " + codigo + " foi alterado com sucesso</p>");
            
            
            
            
            
            
            
        %>
    </body>
</html>
