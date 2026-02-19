# 06 - Laravel Migrations & Seeders

Migrations manage database schema. Seeders populate test data.

## Creating Migrations

```bash
php artisan make:migration create_posts_table
```

## Migration Structure

```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('posts', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('title');
            $table->text('content');
            $table->boolean('published')->default(false);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('posts');
    }
};
```

## Running Migrations

```bash
php artisan migrate
php artisan migrate:rollback
php artisan migrate:refresh
php artisan migrate:fresh
```

## Column Types

```php
$table->id();
$table->string('name');
$table->text('content');
$table->integer('count');
$table->boolean('active');
$table->date('published_at');
$table->timestamp('created_at');
$table->foreignId('user_id');
$table->uuid()->unique();
$table->json('options');
```

## Creating Seeders

```bash
php artisan make:seeder PostSeeder
```

## Seeder Example

```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Post;

class PostSeeder extends Seeder
{
    public function run()
    {
        Post::factory()
            ->count(10)
            ->create();
    }
}
```

## Running Seeders

```php
// Add to DatabaseSeeder
public function run()
{
    $this->call([
        PostSeeder::class,
    ]);
}
```

```bash
php artisan db:seed
php artisan migrate:fresh --seed
```

## Factories (for testing)

```bash
php artisan make:factory PostFactory
```

```php
<?php

namespace Database\Factories;

use App\Models\Post;
use Illuminate\Database\Eloquent\Factories\Factory;

class PostFactory extends Factory
{
    protected $model = Post::class;

    public function definition()
    {
        return [
            'title' => fake()->sentence(),
            'content' => fake()->paragraphs(3, true),
            'published' => fake()->boolean(),
            'user_id' => 1,
        ];
    }
}
```

## Next Steps

- [[07-Laravel-Forms]] - Forms & Validation
