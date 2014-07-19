<?php get_header(); ?>
	
	<div class='page'>
		<header class='row'>
			<?php the_title( '<h1 class="title">', '</h1>' ); ?>
		</header>
		

		<section class='content row'>
			<div class='medium-9 columns medium-centered'>
				<?php while ( have_posts() ) : the_post(); ?>
					

					
					<div class="body-content">
						<?php the_content(); ?>
					</div>

				<?php endwhile; ?>
			</div>
		</section>
	</div>

<?php get_footer(); ?>
