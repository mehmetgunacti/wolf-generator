package ${ info.groupId }.entity.constant;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class ConstantServiceImpl implements ConstantService {

    private final ConstantMapper constantMapper;

    @Override
    public List<Constant> findAll() {

        return constantMapper.findAll();

    }

    @Override
    public Constant create(Constant constant) {

        constantMapper.insert(constant);
        return constant;

    }

    @Override
    public Optional<Constant> findById(String kod) {

        return constantMapper.findById(kod);

    }

    @Override
    public Optional<Constant> modify(Constant constant) {

        constantMapper.update(constant);
        return findById(constant.getCode());

    }

    @Override
    public void deleteById(String code) {

        constantMapper.delete(code);

    }

}
