from flask import Flask, render_template, request, jsonify
import psycopg2
from psycopg2.extras import RealDictCursor

app = Flask(__name__)

# PostgreSQL bağlantı bilgileri
DB_CONFIG = {
    'dbname': 'gameproject',    
    'user': 'postgres',         
    'password': '12345',        
    'host': 'localhost',        
    'port': '5432'             
}

def get_db_connection():
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except psycopg2.Error as e:
        print(f"Veritabanına bağlanırken hata oluştu: {e}")
        return None

@app.route('/')
def home():
    conn = get_db_connection()
    if conn:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        # Tüm oyunları getiriyor
        cur.execute("""
            SELECT g.*, p.publisher_name,
                array_agg(DISTINCT pl.platform_name) as platforms,
                array_agg(DISTINCT gn.genre_name) as genres
            FROM games g 
            LEFT JOIN publishers p ON g.publisher_id = p.publisher_id
            LEFT JOIN game_platform gp ON g.game_id = gp.game_id
            LEFT JOIN platforms pl ON gp.platform_id = pl.platform_id
            LEFT JOIN game_genre gg ON g.game_id = gg.game_id
            LEFT JOIN genres gn ON gg.genre_id = gn.genre_id
            WHERE g.release_year >= 2000
            GROUP BY g.game_id, p.publisher_name
            ORDER BY g.metascore DESC
        """)
        all_games = cur.fetchall()
        
        # İstatistikleri getiriyor
        cur.execute("""
            SELECT 
                COUNT(DISTINCT g.game_id) as game_count,
                COUNT(DISTINCT pl.platform_id) as platform_count,
                COUNT(DISTINCT gn.genre_id) as genre_count,
                MAX(g.metascore) as max_metascore
            FROM games g
            LEFT JOIN game_platform gp ON g.game_id = gp.game_id
            LEFT JOIN platforms pl ON gp.platform_id = pl.platform_id
            LEFT JOIN game_genre gg ON g.game_id = gg.game_id
            LEFT JOIN genres gn ON gg.genre_id = gn.genre_id
            WHERE g.release_year >= 2000
        """)
        stats = cur.fetchone()
        
        cur.close()
        conn.close()
        
        return render_template('index.html', 
                             all_games=all_games,
                             stats=stats)

@app.route('/search')
def search():
    query = request.args.get('q', '')
    conn = get_db_connection()
    cur = conn.cursor(cursor_factory=RealDictCursor)
    
    # Arama sorgusunun olduğu kısım
    sql = """
    SELECT DISTINCT g.*, p.publisher_name,
        array_agg(DISTINCT pl.platform_name) as platforms,
        array_agg(DISTINCT gn.genre_name) as genres
    FROM games g
    LEFT JOIN publishers p ON g.publisher_id = p.publisher_id
    LEFT JOIN game_platform gp ON g.game_id = gp.game_id
    LEFT JOIN platforms pl ON gp.platform_id = pl.platform_id
    LEFT JOIN game_genre gg ON g.game_id = gg.game_id
    LEFT JOIN genres gn ON gg.genre_id = gn.genre_id
    WHERE LOWER(g.title) LIKE LOWER(%s)
    GROUP BY g.game_id, p.publisher_name
    ORDER BY g.metascore DESC;
    """
    cur.execute(sql, [f'%{query}%'])
    games = cur.fetchall()
    
    cur.close()
    conn.close()
    
    return jsonify(games)

@app.route('/games')
def games():
    conn = get_db_connection()
    if conn:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        # Filtreleri alıyor
        platform_id = request.args.get('platform')
        genre_id = request.args.get('genre')
        year = request.args.get('year')
        sort = request.args.get('sort', 'metascore')
        order = request.args.get('order', 'DESC')
        
        # Temel sorguları yapıyor
        sql = """
            SELECT DISTINCT g.*, p.publisher_name,
                array_agg(DISTINCT pl.platform_name) as platforms,
                array_agg(DISTINCT gn.genre_name) as genres
            FROM games g
            LEFT JOIN publishers p ON g.publisher_id = p.publisher_id
            LEFT JOIN game_platform gp ON g.game_id = gp.game_id
            LEFT JOIN platforms pl ON gp.platform_id = pl.platform_id
            LEFT JOIN game_genre gg ON g.game_id = gg.game_id
            LEFT JOIN genres gn ON gg.genre_id = gn.genre_id
        """
        
        conditions = []
        params = []
        
        if platform_id:
            conditions.append("gp.platform_id = %s")
            params.append(platform_id)
        
        if genre_id:
            conditions.append("gg.genre_id = %s")
            params.append(genre_id)
        
        if year:
            conditions.append("g.release_year = %s")
            params.append(year)
        
        if conditions:
            sql += " WHERE " + " AND ".join(conditions)
        
        sql += " GROUP BY g.game_id, p.publisher_name"
        
        # Sıralamayı yapıyor
        valid_sorts = {
            'title': 'g.title',
            'year': 'g.release_year',
            'metascore': 'g.metascore',
            'publisher': 'p.publisher_name'
        }
        sort_column = valid_sorts.get(sort, 'g.metascore')
        sql += f" ORDER BY {sort_column} {order}"
        
        cur.execute(sql, params)
        games = cur.fetchall()
        
        # Platform listesini getir
        cur.execute("SELECT * FROM platforms ORDER BY platform_name")
        platforms = cur.fetchall()
        
        # Tür listesini getir
        cur.execute("SELECT * FROM genres ORDER BY genre_name")
        genres = cur.fetchall()
        
        cur.close()
        conn.close()
        
        return render_template('games.html', 
                             games=games,
                             platforms=platforms,
                             genres=genres)
    return render_template('games.html', error="Veritabanı bağlantısı kurulamadı")

@app.route('/game/<int:game_id>')
def game_detail(game_id):
    conn = get_db_connection()
    if conn:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        # Oyun detaylarını getiriyor
        cur.execute("""
            SELECT g.*, p.publisher_name,
                array_agg(DISTINCT pl.platform_name) as platforms,
                array_agg(DISTINCT gn.genre_name) as genres,
                array_agg(DISTINCT m.mode_name) as modes
            FROM games g
            LEFT JOIN publishers p ON g.publisher_id = p.publisher_id
            LEFT JOIN game_platform gp ON g.game_id = gp.game_id
            LEFT JOIN platforms pl ON gp.platform_id = pl.platform_id
            LEFT JOIN game_genre gg ON g.game_id = gg.game_id
            LEFT JOIN genres gn ON gg.genre_id = gn.genre_id
            LEFT JOIN game_modes gm ON g.game_id = gm.game_id
            LEFT JOIN modes m ON gm.mode_id = m.mode_id
            WHERE g.game_id = %s
            GROUP BY g.game_id, p.publisher_name
        """, (game_id,))
        
        game = cur.fetchone()
        
        # Benzer oyunları getiriyor
        if game:
            cur.execute("""
                SELECT DISTINCT g2.*, p2.publisher_name
                FROM games g2
                LEFT JOIN publishers p2 ON g2.publisher_id = p2.publisher_id
                LEFT JOIN game_genre gg2 ON g2.game_id = gg2.game_id
                WHERE gg2.genre_id IN (
                    SELECT gg1.genre_id 
                    FROM game_genre gg1 
                    WHERE gg1.game_id = %s
                )
                AND g2.game_id != %s
                ORDER BY g2.metascore DESC
                LIMIT 3
            """, (game_id, game_id))
            similar_games = cur.fetchall()
        else:
            similar_games = []
        
        cur.close()
        conn.close()
        
        return render_template('game_detail.html', 
                             game=game,
                             similar_games=similar_games)
    return render_template('game_detail.html', error="Veritabanı bağlantısı kurulamadı")

@app.route('/publishers')
def publishers():
    conn = get_db_connection()
    if conn:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        # Yayıncı istatistiklerini getiriyor
        cur.execute("""
            SELECT p.*, 
                COUNT(g.game_id) as game_count,
                AVG(g.metascore) as avg_metascore,
                SUM(g.sales) as total_sales
            FROM publishers p
            LEFT JOIN games g ON p.publisher_id = g.publisher_id
            GROUP BY p.publisher_id
            ORDER BY game_count DESC
        """)
        publishers = cur.fetchall()
        
        cur.close()
        conn.close()
        
        return render_template('publishers.html', publishers=publishers)
    return render_template('publishers.html', error="Veritabanı bağlantısı kurulamadı")

@app.route('/stats')
def stats():
    conn = get_db_connection()
    if conn:
        cur = conn.cursor(cursor_factory=RealDictCursor)
        
        # Platform istatistiklerini getiriyor.
        cur.execute("""
            SELECT pl.platform_name, 
                COUNT(DISTINCT gp.game_id) as game_count,
                AVG(g.metascore) as avg_metascore
            FROM platforms pl
            LEFT JOIN game_platform gp ON pl.platform_id = gp.platform_id
            LEFT JOIN games g ON gp.game_id = g.game_id
            GROUP BY pl.platform_name
            ORDER BY game_count DESC
        """)
        platform_stats = cur.fetchall()
        
        # Tür istatistiklerini getiriyor.
        cur.execute("""
            SELECT gn.genre_name,
                COUNT(DISTINCT gg.game_id) as game_count,
                AVG(g.metascore) as avg_metascore
            FROM genres gn
            LEFT JOIN game_genre gg ON gn.genre_id = gg.genre_id
            LEFT JOIN games g ON gg.game_id = g.game_id
            GROUP BY gn.genre_name
            ORDER BY game_count DESC
        """)
        genre_stats = cur.fetchall()
        
        # Yıllara göre istatistikleri veriyor.
        cur.execute("""
            SELECT release_year,
                COUNT(*) as game_count,
                AVG(metascore) as avg_metascore,
                SUM(sales) as total_sales
            FROM games
            GROUP BY release_year
            ORDER BY release_year DESC
        """)
        yearly_stats = cur.fetchall()
        
        cur.close()
        conn.close()
        
        return render_template('stats.html',
                             platform_stats=platform_stats,
                             genre_stats=genre_stats,
                             yearly_stats=yearly_stats)
    return render_template('stats.html', error="Veritabanı bağlantısı kurulamadı")

if __name__ == '__main__':
    app.run(debug=True)