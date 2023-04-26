package itstep.learning.ioc;
import com.google.inject.AbstractModule;
import itstep.learning.service.DbService;
import itstep.learning.service.LocalDbService;
import itstep.learning.service.Md5Hash;
import itstep.learning.service.HashService;
import itstep.learning.data.dao.IUserDao;
import itstep.learning.data.dao.UserDao;
import itstep.learning.service.AuthService;
import itstep.learning.service.SessionAuthService;

public class ServiceModule extends AbstractModule {
    @Override
    protected void configure() {
        bind(DbService.class).to(LocalDbService.class);
        bind(HashService.class).to(Md5Hash.class);
        bind(IUserDao.class).to(UserDao.class);
        bind(AuthService.class).to(SessionAuthService.class);
    }
}