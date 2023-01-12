package com.wolf359apps.wolfgen.util;

import com.wolf359apps.wolfgen.exception.FileSystemException;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Objects;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

public final class ZipUtil {

//    // For testing
//    public static void main(String[] args) throws IOException {
//
//        String folder = "/home/mserkan/Temporary/";
//        compressFile(new File(folder + "abc.jdl"), new File(folder + "abc.jdl.zip"));
//
//        // compressFile(new File(folder + "backup.sql"), new File(folder + "abc.jdl.zip"));
//
////        compressDirectory(new File(folder + "test1"), new File(folder + "test1_zipped.zip"));
//        extractArchive(new File(folder + "test2"), new File(folder + "abc.jdl.zip"));
//
//    }

    public static void compressDirectory(File sourceDirectory, File zipFile) {

        if (!sourceDirectory.exists())
            throw new FileSystemException("Source directory does not exists");

        try (
                ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFile))
        ) {

            compressDirectory(sourceDirectory.getAbsoluteFile(), sourceDirectory, out);

        } catch (Exception e) {

            throw new FileSystemException("Error extracting archive", e);

        }

    }

    private static void compressDirectory(File rootDir, File sourceDir, ZipOutputStream out) throws IOException {

        for (
                File file : Objects.requireNonNull(sourceDir.listFiles())
        ) {

            if (file.isDirectory())
                compressDirectory(rootDir, new File(sourceDir, file.getName()), out);

            else {

                String zipEntryName = getRelativeZipEntryName(rootDir, file);
                compressFile(out, file, zipEntryName);

            }

        }

    }

    private static String getRelativeZipEntryName(File rootDir, File file) {

        return StringUtils.removeStart(file.getAbsolutePath(), rootDir.getAbsolutePath());

    }

    public static void compressFile(File file, File zipFile) {

        try (
                ZipOutputStream out = new ZipOutputStream(new FileOutputStream(zipFile))
        ) {

            compressFile(out, file, file.getName());

        } catch (Exception e) {

            throw new FileSystemException("Error extracting archive", e);

        }

    }

    private static void compressFile(ZipOutputStream out, File file, String zipEntityName) throws IOException {

        ZipEntry entry = new ZipEntry(zipEntityName);
        out.putNextEntry(entry);

        try (
                FileInputStream in = new FileInputStream(file)
        ) {

            IOUtils.copy(in, out);

        }

    }

    public static void extractArchive(File targetDirectory, File zipFile) {

        try (
                ZipInputStream zis = new ZipInputStream(new FileInputStream(zipFile))
        ) {

            extractStream(targetDirectory, zis);

        } catch (Exception e) {

            throw new FileSystemException("Error extracting archive", e);

        }

    }

    private static void extractStream(File targetDirectory, ZipInputStream zis) throws IOException {

        ZipEntry zipEntry = zis.getNextEntry();
        while (zipEntry != null) {

            extractEntry(targetDirectory, zis, zipEntry);
            zipEntry = zis.getNextEntry();

        }
        zis.closeEntry();

    }

    private static void extractEntry(File targetDirectory, ZipInputStream zis, ZipEntry zipEntry) throws IOException {

        File newFile = newFile(targetDirectory, zipEntry);
        if (zipEntry.isDirectory())
            FileUtils.forceMkdir(newFile);

        else {

            FileUtils.forceMkdirParent(newFile);
            try (
                    FileOutputStream fos = new FileOutputStream(newFile)
            ) {

                IOUtils.copy(zis, fos);

            }

        }

    }

    private static File newFile(File targetDirectory, ZipEntry zipEntry) throws IOException {

        File targetFile = new File(targetDirectory, zipEntry.getName());

        String targetDirPath  = targetDirectory.getCanonicalPath();
        String targetFilePath = targetFile.getCanonicalPath();

        if (!targetFilePath.startsWith(targetDirPath + File.separator))
            throw new IOException("Entry is outside of the target dir: " + zipEntry.getName());

        return targetFile;

    }

}