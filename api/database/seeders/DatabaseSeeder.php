<?php

namespace Database\Seeders;

use App\Models\Company;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;
use Spatie\Permission\Models\Role;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $roles = ['Admin', 'Storekeeper', 'Viewer'];
        foreach ($roles as $role) {
            Role::firstOrCreate(['name' => $role, 'guard_name' => 'sanctum']);
        }

        $company = Company::firstOrCreate(
            ['slug' => 'shams-demo'],
            ['name' => 'Shams Projects', 'email' => 'admin@example.com']
        );

        $admin = User::firstOrCreate(
            ['email' => 'admin@example.com'],
            [
                'name' => 'Admin',
                'password' => Hash::make('password'),
                'must_change_password' => true,
            ]
        );

        $admin->companies()->syncWithoutDetaching([$company->id => ['is_primary' => true]]);
        $admin->current_company_id = $company->id;
        $admin->save();
        $admin->assignRole('Admin');
    }
}
