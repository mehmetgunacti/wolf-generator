package com.wolf359apps.wolfgen.util.filesystem;

import com.wolf359apps.wolfgen.exception.FileSystemException;
import com.wolf359apps.wolfgen.util.FileUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.nio.file.Path;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class FileModifierServiceImpl implements FileModifierService {

    // private final FileSystemService fileSystemService;

    @Override
    public void addAfter(List<String> lines, String searchKeyword, String newLine) {

        lines.add(
                findLineIndex(lines, searchKeyword) + 1,
                newLine
        );

    }

    @Override
    public void replaceLine(Path filePath, String searchKeyword, String newLineValue) {

        List<String> lines = FileUtil.readFile(filePath);
        replaceLine(lines, searchKeyword, newLineValue);
        FileUtil.createFile(filePath, lines);

    }

    @Override
    public void replaceLine(List<String> lines, String searchKeyword, String newValue) {

        lines.set(
                findLineIndex(lines, searchKeyword),
                newValue
        );

    }

    @Override
    public void replaceLine(List<String> lines, String[] searchKeywords, String newValue) {

        int idx = findLineIndex(lines, searchKeywords[0]);
        for (int i = 1; i < searchKeywords.length; ++i) {

            if (!lines.get(idx + i).equals(searchKeywords[i]))
                throw new FileSystemException("Search keyword not found: " + searchKeywords[i]);

        }
        replaceLine(lines, searchKeywords[searchKeywords.length - 1], newValue);

    }

    private int findLineIndex(List<String> lines, String searchKeyword) {

        return Optional
                .of(
                        lines.indexOf(searchKeyword) // returns line index as int
                )
                .filter(idx -> idx > 0)
                .orElseThrow(() -> new FileSystemException("Search keyword not found: " + searchKeyword));

    }

}
