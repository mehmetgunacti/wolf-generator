package com.wolf359apps.wolfgen.util.filesystem;

import java.nio.file.Path;
import java.util.List;

public interface FileModifierService {

    void addAfter(List<String> lines, String searchKeyword, String newLine);

    void replaceLine(Path file, String searchKeyword, String newValue);

    void replaceLine(List<String> lines, String searchKeyword, String newValue);

    void replaceLine(List<String> lines, String[] searchKeywords, String newValue);

}
