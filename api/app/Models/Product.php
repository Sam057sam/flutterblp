<?php

namespace App\Models;

use App\Models\Traits\BelongsToCompany;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory, BelongsToCompany;

    protected $fillable = [
        'company_id',
        'sku',
        'name',
        'description',
        'price',
        'cost',
        'stock',
        'unit',
    ];

    protected $casts = [
        'price' => 'decimal:2',
        'cost' => 'decimal:2',
    ];
}
