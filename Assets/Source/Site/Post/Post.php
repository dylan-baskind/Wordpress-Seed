<article class='full-post row' id="post-<?php the_ID(); ?>" <?php post_class(); ?>>
	<div class='medium-8 columns medium-centered'>
		<?php include(source() . "/Site/Post/Header/Header.php"); ?>

		<figure>
			<?php the_post_thumbnail('large'); ?>
		</figure>

		<div class="body-content">
			<?php the_content(); ?>
		</div>

		<?php include(source() . "/Site/Post/Footer/Footer.php"); ?>
	</div>
</article><!-- #post-## -->
