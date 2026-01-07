<?php

namespace App\Models;

use App\Models\Traits\BelongsToCompany;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Media extends Model
{
    use HasFactory, BelongsToCompany;

    protected $fillable = [
        'company_id',
        'disk',
        'path',
        'filename',
        'mime_type',
        'size',
    ];
}
