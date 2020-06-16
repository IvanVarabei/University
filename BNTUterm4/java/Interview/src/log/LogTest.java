package log;

import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.LogManager;
import java.util.logging.Logger;

public class LogTest{
    static Logger LOGGER;
    static {
        try(FileInputStream ins = new FileInputStream("C:\\fourth\\java\\Interview\\src\\log.config")){ //������ ���� �� ����� � ���������
            LogManager.getLogManager().readConfiguration(ins);
            LOGGER = Logger.getLogger(LogTest.class.getName());
        }catch (Exception ignore){
            ignore.printStackTrace();
        }
    }
    public static void main(String[] args) {
        try {
            LOGGER.fine("������ main");
          throw null;

        }catch (Exception e){
            LOGGER.log(Level.WARNING,"���-�� ����� �� ���" , e);
        }
    }
}
