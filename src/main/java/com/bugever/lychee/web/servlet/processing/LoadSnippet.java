package com.bugever.lychee.web.servlet.processing;

import com.bugever.lychee.database.Database;
import com.bugever.lychee.domain.Snippet;
import com.bugever.lychee.util.ParameterizedQuery;
import com.bugever.lychee.web.servlet.ServletHandler;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_SELLER;
import static com.bugever.lychee.web.servlet.Helper.TOKEN_ATTR_USER;

// curl 'http://127.0.0.1:8080/api/processing/load-snippet' -d '{}'
@WebServlet("/api/processing/load-snippet")
public class LoadSnippet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) {
        ServletHandler.handle(request, response, (currentUser) -> {
            Snippet snippet = new Snippet();
            ParameterizedQuery query = new ParameterizedQuery(
                    "select id, content, updated_on, created_on" +
                            " from m_snippets where id = ? and seller_id = ?",
                    currentUser.attributes.get(TOKEN_ATTR_USER), currentUser.attributes.get(TOKEN_ATTR_SELLER)
            );
            List<Snippet> list = Database.list(Snippet.class, query.sql(), query.params());
            if (!list.isEmpty()) {
                snippet = list.iterator().next();
            }
            return snippet;
        });
    }
}
