import java.io.*;
import java.nio.file.*;
import javax.swing.*;

public class Installer
{
    private static final String TERRARIA_VERSION = "v1.3.0.8";

    public static void tryInstall(String[] files, File directory)
    {
        try
        {
            install(files, directory);
        }
        catch (IOException e)
        {
            messageBox("A problem was encountered while installing!\n" + e, JOptionPane.ERROR_MESSAGE);
        }
    }

    private static void install(String[] files, File directory) throws IOException
    {
        if (directory == null || !directory.exists())
        {
            messageBox("Could not find place to install to!", JOptionPane.ERROR_MESSAGE);
            return;
        }
        File terraria = new File(directory, "Terraria.exe");
        File terrariaBackup = new File(directory, "Terraria_" + TERRARIA_VERSION + ".exe");
        if (!terraria.exists())
        {
            messageBox("Could not find your Terraria.exe file!", JOptionPane.ERROR_MESSAGE);
            return;
        }
        if (!terrariaBackup.exists())
        {
            copy(terraria, terrariaBackup);
        }
        String badFiles = "\n";
        for (String file : files)
        {
            File source = new File(file);
            if (source.exists())
            {
                File destination = new File(directory, file);
                copy(source, destination);
            }
            else
            {
                badFiles += file + "\n";
            }
        }
        if (badFiles.length() > 1)
        {
            messageBox("The following files were missing and could not be installed:" + badFiles + "All the other files have been installed properly.", JOptionPane.ERROR_MESSAGE);
            return;
        }
        messageBox("Installation successful!", JOptionPane.INFORMATION_MESSAGE);
    }

    private static void copy(File source, File destination) throws IOException
    {
        Files.copy(source.toPath(), destination.toPath(), StandardCopyOption.REPLACE_EXISTING);
    }

    private static void messageBox(String message, int messageType)
    {
        JOptionPane.showMessageDialog(null, message, "tModLoader Installer", messageType);
    }
}
