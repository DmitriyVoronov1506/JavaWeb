package itstep.learning.data.dao;

import com.google.inject.Inject;
import com.google.inject.Singleton;
import itstep.learning.data.entity.Team;
import itstep.learning.data.entity.User;
import itstep.learning.service.DbService;
import itstep.learning.data.entity.Entity;
import itstep.learning.model.TaskModel;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Singleton
public class TeamDao {
    private final DbService dbService;
    private final Logger logger;

    @Inject
    public TeamDao(DbService dbService, Logger logger) {
        this.dbService = dbService;
        this.logger = logger;
    }

    public List<Team> getAll() {

        try (Statement statement = dbService.getConnection().createStatement()) {

            ResultSet res = statement.executeQuery("SELECT t.* FROM `teams` t");

            List<Team> teams = new ArrayList<>();

            while (res.next()){
                teams.add(new Team(res));
            }

            return teams;
        }
        catch (SQLException ex) {
            logger.log(Level.WARNING, ex.getMessage());
            return null;
        }
    }

    public List<Team> getUserTeams(User user) {

        String sql = "SELECT t.* FROM `teams` t JOIN `teams_users` tu " +
                "ON t.`id` = tu.`id_team` WHERE tu.`id_user` = ?";

        try (PreparedStatement prep = dbService.getConnection().prepareStatement(sql)) {

            prep.setString(1, user.getId().toString());
            ResultSet res = prep.executeQuery();

            List<Team> teams = new ArrayList<>();

            while (res.next()) {
                teams.add(new Team(res));
            }

            return teams;
        }
        catch (SQLException ex) {
            logger.log(Level.WARNING, ex.getMessage());
            return null;
        }
    }

    public boolean addTeam(String teamName) {

        String sql = "INSERT INTO `teams` (`id`,`name`) VALUES(UUID(), ?)";

        try (PreparedStatement prep = dbService.getConnection().prepareStatement(sql)) {

            prep.setString(1, teamName);
            prep.executeUpdate();

            return true;
        }
        catch (SQLException ex) {
            logger.log(Level.WARNING, ex.getMessage());
            return false;
        }
    }

    public boolean isTeamExist(String teamName) {

        String sql = "SELECT COUNT(*) FROM Teams t WHERE t.name = '" + teamName + "'";

        try (Statement statement = dbService.getConnection().createStatement()) {

            ResultSet resultSet = statement.executeQuery(sql);
            resultSet.next();

            return resultSet.getInt(1) == 0 ? false : true;
        }
        catch (SQLException ex) {
            logger.log(Level.WARNING, ex.getMessage());
            return true;
        }
    }

    public boolean addUserToTeam(String id_team, String id_user) {

        String sql = "INSERT INTO `teams_users` (`id_team`,`id_user`) VALUES(?, ?)";

        try (PreparedStatement prep = dbService.getConnection().prepareStatement(sql)) {

            prep.setString(1, id_team);
            prep.setString(2, id_user);
            prep.executeUpdate();

            return true;
        }
        catch (SQLException ex) {
            logger.log(Level.WARNING, ex.getMessage());
            return false;
        }
    }

    public boolean isUserExist(String id_team, String id_user) {

        String sql = "SELECT COUNT(*) FROM `teams_users` tu WHERE tu.id_team = '"
                + id_team + "' AND tu.id_user = '" + id_user + "'";

        try (Statement statement = dbService.getConnection().createStatement()) {

            ResultSet resultSet = statement.executeQuery(sql);
            resultSet.next();

            return resultSet.getInt(1) == 0 ? false : true;
        }
        catch (SQLException ex) {
            logger.log(Level.WARNING, ex.getMessage());
            return true;
        }
    }
}