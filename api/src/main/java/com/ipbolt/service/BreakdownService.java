package com.ipbolt.service;

import com.ipbolt.repository.BreakdownRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@RequiredArgsConstructor
public class BreakdownService {
    private final BreakdownRepository breakdownRepository;

}