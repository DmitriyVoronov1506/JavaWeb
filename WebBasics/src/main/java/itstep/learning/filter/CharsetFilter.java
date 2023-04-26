package itstep.learning.filter;
import com.google.inject.Singleton;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Singleton
public class CharsetFilter implements Filter {
    private FilterConfig filterConfig ;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig ;
    }

    @Override
    public void doFilter(
            ServletRequest  servletRequest,   // обобщенный тип ServletRequest
            ServletResponse servletResponse,  // реально это HttpServletRequest
            FilterChain filterChain           // цепочка фильтров
    ) throws IOException, ServletException
    {
        HttpServletRequest req = (HttpServletRequest) servletRequest ;
        HttpServletResponse resp = (HttpServletResponse) servletResponse ;

        req.setCharacterEncoding( "UTF-8" ) ;  // установка кодировки чтения из запроса. ДО ПЕРВОГО ЧТЕНИЯ
        resp.setCharacterEncoding( "UTF-8" ) ;
        // цепочку фильтров необходимо продолжить. Иначе она будет прервана и запрос прекратит обработку
        filterChain.doFilter( servletRequest, servletResponse ) ;
        // после вызова цепочки - обратный ход (обработка ответа)
    }

    @Override
    public void destroy() {
        filterConfig = null ;
    }
}