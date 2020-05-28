package log;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.*;
public class MyLogger{
    static Logger LOGGER;
    static {
        try(FileInputStream ins = new FileInputStream("C:\\fourth\\java\\Interview\\src\\log.config")){ //������ ���� �� ����� � ���������
            LogManager.getLogManager().readConfiguration(ins);
            LOGGER = Logger.getLogger(MyLogger.class.getName());
        }catch (Exception ignore){
            ignore.printStackTrace();
        }
    }
    public static void main(String[] args) {
        try {
            LOGGER.info("������ main, ������� ���� � ���������� Integers");
            List<Integer> ints = new ArrayList<Integer>();
            LOGGER.log(Level.INFO,"����������� ���� Integers ����� ��� ����������");
            List empty = ints;
            LOGGER.log(Level.INFO,"����������� ���� ��� ���������� ����� �����");
            List<String> string = empty;
            LOGGER.log(Level.WARNING,"��������� ������ \"��� ���\" � ��� ��������������� ����, �������� ������");
            string.add("��� ���");
            LOGGER.log(Level.WARNING,"��������� ������ \"��� 23\" � ��� ��������������� ����, �������� ������");
            string.add("��� 23");
            LOGGER.warning("��������� ������ \"��� 34\" � ��� ��������������� ����, �������� ������");
            string.add("��� 34");


            LOGGER.log(Level.INFO,"������� ��� �������� ����� � ���������� Integers � �������");
            for (Object anInt : ints) {
                System.out.println(anInt);
            }

            LOGGER.log(Level.INFO,"������ ����� " + ints.size());
            LOGGER.log(Level.INFO,"������� ������ �������");
            Integer integer = ints.get(0);
            LOGGER.log(Level.INFO,"������� ��� � �������");
            System.out.println(integer);

        }catch (Exception e){
            LOGGER.log(Level.WARNING,"���-�� ����� �� ���" , e);
        }
    }
}
