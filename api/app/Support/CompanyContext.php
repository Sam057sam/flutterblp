<?php

namespace App\Support;

class CompanyContext
{
    private ?int $companyId = null;

    public function setCompanyId(?int $companyId): void
    {
        $this->companyId = $companyId;
    }

    public function companyId(): ?int
    {
        return $this->companyId;
    }
}
