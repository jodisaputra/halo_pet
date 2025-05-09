<!doctype html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="dns-prefetch" href="//fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=Nunito" rel="stylesheet">

    <!-- Scripts -->
    @vite(['resources/sass/app.scss', 'resources/js/app.js'])
</head>
<body>
    <div id="app">
        <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
            <div class="container">
                <a class="navbar-brand" href="/">Halo Pet</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item {{ request()->is('home') ? 'active' : '' }}">
                            <a class="nav-link" href="/home">Home</a>
                        </li>
                        <li class="nav-item {{ request()->is('doctors*') ? 'active' : '' }}">
                            <a class="nav-link" href="/doctors">Doctors</a>
                        </li>
                        <li class="nav-item {{ request()->is('hospitals*') ? 'active' : '' }}">
                            <a class="nav-link" href="/hospitals">Hospitals</a>
                        </li>
                        <li class="nav-item {{ request()->is('shops*') ? 'active' : '' }}">
                            <a class="nav-link" href="/shops">Shops</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <main class="py-4">
            @yield('content')
        </main>
    </div>
</body>
</html>
