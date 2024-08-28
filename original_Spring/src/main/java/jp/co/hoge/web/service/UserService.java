package jp.co.hoge.web.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jp.co.hoge.web.repository.UserInfoRepository;

@Service
public class UserService {

    @Autowired
    private UserInfoRepository userInfoRepository;

    @Transactional
    public void deleteUserByLoginId(String loginId) {
        userInfoRepository.deleteByLoginId(loginId);
    }

    public boolean existsById(Long userId) {
        return userInfoRepository.existsById(userId);
    }
}
